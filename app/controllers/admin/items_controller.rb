class Admin::ItemsController < ApplicationController
  before_action :set_item, only: %i[ show update destroy ]
  before_action :authenticate_admin
  before_action :authenticate_user, only: %i[ :authenticate_admin ]
  # GET /admin/items
  def index
    @items = Item.all

    render json: @items
  end

  # GET /admin/items/1
  def show
    render json: @item
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

  # DELETE /admin/items/1
  def destroy
    @item.destroy
  end

  def dashboard
    @orders = Order.all
    render json: @orders
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.fetch(:item, {})
    end

    def authenticate_admin
      unless current_user&.admin?
        render json: "Vous n'êtes pas administrateur."
      end
    end
end
