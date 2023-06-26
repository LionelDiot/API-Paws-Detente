class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy
    has_many :items, through: :line_items
    belongs_to :user
    
      # LOGIC
  def cart_total
    sum = 0
    self.line_items.each do |line_item|
      sum+= line_item.line_item_price
    end
    return sum
  end

  def add_line_item(item, quantity)
    line_item = self.line_items.find_or_initialize_by(item_id: item.id)
    line_item.quantity ||= 0
    line_item.quantity += quantity
    line_item.save
    line_item
  end

  def edit_line_item(item, quantity)
    line_item = self.line_items.find_by(item_id: item.id)
    if line_item
      line_item.quantity = quantity
      line_item.save
    end
  
    line_item
  end
  
  def delete_line_item(item)
    line_item = self.line_items.find_by(item_id: item.id)
    line_item.destroy if line_item
  end

  def empty_cart
    line_items.destroy_all
  end
  
end
