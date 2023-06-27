class MembersController < ApplicationController
  before_action :authenticate_user!

	def show
	  user = current_user
  	render json: {
      user: user,
      orders: user.orders
  	}
  end

  def index
    favorites = current_user.favorite_items
    render json: favorites
  end

  def switch
    item_id = params[:item_id]
    item = Item.find(item_id)
  
    if current_user.favorite_items.exists?(item_id)
      current_user.favorite_items.find_by(item_id: item_id).destroy
      render json: { message: 'Item removed from favorites' }
    else
      current_user.favorite_items.create(item: item)
      render json: { message: 'Item added to favorites' }
    end
  end


  private

  # def get_user_from_token
  #   jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
  #   ENV['DEVISE_JWT_SECRET_KEY']).first
  #   user_id = jwt_payload['sub']
  #   User.find(user_id.to_s)
  # end

end