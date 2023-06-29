class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :user, presence: true
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def summary_order_mailer
      UserMailer.purchase_email(self).deliver_later        
  end

  def fill_order(cart)
    cart.line_items.each do |line_item|
      self.order_items.create(
        quantity: line_item.quantity,
        item_title: line_item.title,
        item_price: line_item.price,
        line_item_price: line_item.line_item_price
      )
    end
    summary_order_mailer
  end
end
