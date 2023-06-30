FactoryBot.define do
  factory :item do
    title { Faker::Commerce.product_name }
    description { "MyText" }
    price { Faker::Commerce.price(range: 1..100)*100 }
    image_url { "www.monimage.com" }
  end
end

