class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show update destroy ]
  before_action :is_admin, only: %i[ create update destroy ]
  before_action :authenticate_user, only: %i[is_admin]
  # GET /items
  def index
    @items = Item.all    
    render json: @items 
  end

  # GET /items/1
  def show
    render json: @item
  end

  # POST /items
  def create
    unless is_admin
      render json: { error: "Vous n'êtes pas authorisé à créer un article." }, status: :unauthorized
      return
    end
    @item = Item.new(item_params)

    if @item.save
      render json: @item, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    unless is_admin
      render json: { error: "Vous n'êtes pas authorisé à modifier un article." }, status: :unauthorized
      return
    end
    
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    unless is_admin
      render json: { error: "Vous n'êtes pas authorisé à supprimer un article." }, status: :unauthorized
      return
    end
    
    @item.destroy
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

    def is_admin
      unless current_user === User.find_by(user_id => 1)  
        return false
      end
      return true
    end
end
