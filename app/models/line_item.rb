class LineItem < ApplicationRecord
    belongs_to :item
    belongs_to :cart

    validates :item_id, presence: true
    validates :cart_id, presence: true
    validates :item_id, uniqueness: { scope: :cart_id, message: "has already been added to the cart" }
    
    # LOGIC
  def total_price
    self.quantity * self.product.price
  end
end
