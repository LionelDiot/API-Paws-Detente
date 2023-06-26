FactoryBot.define do
  factory :order_item do
    order { nil }
    item_title { "MyString" }
    item_description { "MyText" }
    item_price { "9.99" }
    item_image_url { "MyString" }
    quantity { 1 }
    line_item_price { "9.99" }
  end
end
