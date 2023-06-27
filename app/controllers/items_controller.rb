class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show ]
  before_action :get_user_from_token

  # GET /items
def index
  @items = Item.all

  if @user
    favorites = @user.favorite_items.pluck(:item_id)
    @items = @items.map do |item|
      item_hash = item.as_json
      item_hash['favorite'] = favorites.include?(item.id)
      item_hash
    end
  end

  render json: @items
end

  # GET /items/1
  def show
    if @user
      favorites = @user.favorite_items.pluck(:item_id)
      item_hash = @item.as_json
      item_hash['favorite'] = favorites.include?(@item.id)
      render json: item_hash
      return
    end
    render json: @item
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:title, :description, :price, :image_url)
    end

    def get_user_from_token
      @user = user_signed_in? ? current_user : nil
    end
    
end
