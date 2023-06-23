class LineItem < ApplicationRecord
    belongs_to :item
    belongs_to :cart

    validates :item_id, presence: true
    validates :cart_id, presence: true
    validates :item_id, uniqueness: { scope: :cart_id, message: "has already been added to the cart" }

    after_save :check_quantity
    
    # LOGIC
  def line_item_price
    self.quantity * self.item.price
  end

  def check_quantity
    self.cart.line_items.each do |line_item|
      line_item.destroy if line_item.quantity.to_i <= 0
    end
  end
end
