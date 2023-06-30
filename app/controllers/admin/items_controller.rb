class Admin::ItemsController < ApplicationController
  before_action :set_item, only: %i[ show update destroy ]
  before_action :authenticate_admin
  before_action :authenticate_user, only: %i[ :authenticate_admin ]
  # GET /admin/items
  def index
    @items = Item.order(updated_at: :desc)
    render json: @items
  end


  # POST /admin/items
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: @item, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/items/1
  def update
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end


  def dashboard
    @orders = Order.order(updated_at: :desc)
    render json: @orders
  end

  # DELETE /admin/items/1
  # def destroy
  #   @item.destroy
  # end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:title, :description, :price, :image_url, :category)
    end    

    def authenticate_admin
      unless current_user&.admin?
        render json: "Vous n'êtes pas administrateur."
      end
    end
end
