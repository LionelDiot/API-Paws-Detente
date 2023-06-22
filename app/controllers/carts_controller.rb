class CartsController < ApplicationController
  before_action :authenticate_user!, only: %i[set_cart]
  before_action :set_cart
  before_action :find_item, only: %i[add edit destroy]
  before_action :find_quantity, only: %i[add edit destroy]
  
  def show
    cart_data = {
      line_items: []
    }
  
    @current_cart.line_items.each do |line_item|
      item_data = {
        item_id: line_item.item_id,
        item_title: line_item.item.title,
        quantity: line_item.quantity,
        description: line_item.item.description,
        price: line_item.item.price,
        image_url: line_item.item.image_url
      }
      cart_data[:line_items] << item_data
    end
  
    render json: cart_data
  end
  
    
    def add
      if @item && @quantity
        @current_cart.add_line_item(@item, @quantity)
        render json: @current_cart.line_items, status: :created
      elsif @item && !@quantity 
        @current_cart.add_line_item(@item)
        render json: @current_cart.line_items, status: :created
      else
        render json: { error: 'Item non valide' }, status: :unprocessable_entity
      end
    end

    def edit
  
      if @item && @quantity
        
        @current_cart.edit_line_item(@item, @quantity)
        
        render json: @current_cart.line_items.reload
      else
        render json: { error: 'Item ou quantité non valide' }, status: :unprocessable_entity
      end
    end

    def destroy

      if @item
        @current_cart.delete_line_item(@item)
        render json: @current_cart.line_items.reload
      else
        render json: { error: 'Item non valide' }, status: :unprocessable_entity
      end
    end

    
    private
    def set_cart
      unless current_user
        render json: { error: "Vous n'êtes pas connecté" }, status: :unauthorized
        return
      end
      @current_cart = current_user.cart
    end

    def find_item
      @item = Item.find_by(id: params[:item_id])
    end
    
    def find_quantity
      @quantity = params[:quantity].presence || 1
    end
end
