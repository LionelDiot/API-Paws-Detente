FactoryBot.define do
  factory :item do
    sequence(:title) { |n| "Item n°#{n}"  }
    description { "MyText" }
    sequence(:price) { |n| n  }
    image_url { "www.monimage.com" }
  end
end
