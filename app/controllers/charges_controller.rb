class ChargesController < ApplicationController
  def create_checkout_session
    
    @session = Stripe::Checkout::Session.create(
      line_items: [{
        price_data: {
          currency: 'eur',
          product_data: {
            name: 'Mon Panier',
          },
          unit_amount: 12345,
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: 'http://localhost:3001/payment-success',
      cancel_url: 'http://localhost:3001/payment-fail'
    )
    puts "#" * 30
    puts "le session id est : #{@session.id}"
    puts "#" * 30
    render json: { sessionId: @session.id }
  end

  # def success
  #   @user = current_user
  #   @cart = Cart.find_by(user_id: @user.id)
  #   @session = Stripe::Checkout::Session.retrieve(params[:session_id])
  #   @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

  #   @order = Order.create!(user_id: @user.id)
  #   @order.fill_order(@cart)
    
  #   @cart.selections.destroy_all
  #   #il faut finir de compléter le Order et vider le panier
  # end
end
