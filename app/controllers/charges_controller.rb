class ChargesController < ApplicationController
  before_action :authenticate_user!, only: %i[ create_checkout_session ]
  skip_before_action :verify_authenticity_token, only: %i[ success ]

  def create_checkout_session
    amount = (params.require(:amount).to_f * 100).to_i

    @session = Stripe::Checkout::Session.create(
      line_items: [{
        price_data: {
          currency: 'eur',
          product_data: {
            name: 'Mon Panier',
          },
          unit_amount: amount,
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: 'https://paws-detente.vercel.app/payment-success',
      cancel_url: 'https://paws-detente.vercel.app/payment-fail',
      metadata: {
        client_reference_id: current_user.id 
      }
    )
    render json: { sessionId: @session.id }
  end

  def success
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = ENV['SRIPE_SIGNING_SECRET'] 
  
    # Verify the webhook signature
    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError => e
      # Handle JSON parsing error
      return head :bad_request
    rescue Stripe::SignatureVerificationError => e
      # Handle signature verification error
      return head :bad_request
    end
  
    # Handle the checkout.session.completed event
    if event['type'] == 'checkout.session.completed'
      session = event['data']['object']
  
      # Retrieve the relevant data from the session and payment intent
      session_id = session['id']
      payment_intent_id = session['payment_intent']
      user_id = session['client_reference_id']
  
      # Retrieve the user, cart, and payment intent from your Rails models
      @user = User.find(user_id)
      @cart = Cart.find_by(user_id: @user.id)
      @payment_intent = Stripe::PaymentIntent.retrieve(payment_intent_id)
  
      # Create the order
      @order = Order.create!(user_id: @user.id, total: @cart.cart_total)
      @order.fill_order(@cart)
  
      # Empty the cart
      @cart.empty_cart
    end
  
    head :ok
  end
end
