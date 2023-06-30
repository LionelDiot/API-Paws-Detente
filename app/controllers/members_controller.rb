class MembersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorised, only: %i[ order_details ]
  before_action :find_order, only: %i[ order_details authorised]
  def order_details

    order_data = {
      order: @order,
      order_items: []
    }

    @order.order_items.each do |order_item|
      item_data = {
        item_title: order_item.item_title,
        price: order_item.item_price,
        quantity: order_item.quantity,
        order_item_price: order_item.line_item_price
      }
      order_data[:order_items] << item_data
    end
    render json: order_data
  end

  def update_password
    if current_user.update_with_password(update_password_params)
      bypass_sign_in(current_user)
      render json: { message: 'Changement de mot de passe réussi' }, status: :ok
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_email
    if current_user.update(email: update_email_params[:email])
      render json: { message: "Changement d'email réussi", email: current_user.email }, status: :ok
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    user = current_user
    sorted_orders = user.orders.sort_by { |order| order.updated_at }.reverse
  
    render json: {
      user: user,
      orders: sorted_orders
    }
  end

  def index

      favorites = current_user.favorite_items.map do |favorite_item|
        item = favorite_item.item
        item_hash = item.as_json
        item_hash['favorite'] = true
        item_hash
      end
      sorted_favorites = favorites.sort_by { |item| item['updated_at'] }.reverse
  render json: sorted_favorites

  end

  def switch
    item_id = params[:item_id]
    item = Item.find(item_id)
  
    if current_user.favorite_items.exists?(item_id: item_id)
      current_user.favorite_items.find_by(item_id: item_id).destroy
      render json: { message: 'Retiré des favoris' }
    else
      current_user.favorite_items.create(item: item)
      render json: { message: 'Ajouté aux favoris' }
    end
  end
  
  private

  def update_email_params
    params.require(:user).permit(:email)
  end

  def update_password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end

  def authorised
    unless current_user&.admin? || current_user == @order.user
      render json: "Vous n'avez pas le droit de voir cette commande."
    end
  end

  def find_order
    @order = Order.find_by(id: params[:order_id])
  end


end