class OrderItem < ApplicationRecord
  belongs_to :order

  validates :order, presence: true
  validates :item_title, presence: true
  validates :item_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :line_item_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
