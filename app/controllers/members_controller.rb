class MembersController < ApplicationController
  before_action :authenticate_user!

  def update_password
    if current_user.update_with_password(update_password_params)
      bypass_sign_in(current_user)
      render json: { message: 'Password updated successfully.' }, status: :ok
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_email
    if current_user.update(email: update_email_params[:email])
      render json: { message: 'Email updated successfully.', email: current_user.email }, status: :ok
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

	def show
	  user = current_user
  	render json: {
      user: user,
      orders: user.orders
  	}
  end

  def index

      favorites = current_user.favorite_items.map do |favorite_item|
        item = favorite_item.item
        item_hash = item.as_json
        item_hash['favorite'] = true
        item_hash
      end
      render json: favorites

  end

  def switch
    item_id = params[:item_id]
    item = Item.find(item_id)
  
    if current_user.favorite_items.exists?(item_id: item_id)
      current_user.favorite_items.find_by(item_id: item_id).destroy
      render json: { message: 'Item removed from favorites' }
    else
      current_user.favorite_items.create(item: item)
      render json: { message: 'Item added to favorites' }
    end
  end
  
  private

  def update_email_params
    params.require(:user).permit(:email)
  end

  def update_password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end