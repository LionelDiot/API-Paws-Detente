FactoryBot.define do
  factory :order_item do
    order { FactoryBot.create(:order) }
    sequence(:item_title) { |n| "Item title n°#{n}" }
    item_price { 1200 }
    quantity { 1 }
    line_item_price { item_price * quantity }
  end
end
