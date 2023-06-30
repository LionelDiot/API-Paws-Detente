FactoryBot.define do
  factory :line_item do
    cart { FactoryBot.create(:cart) }
    item { FactoryBot.create(:item) }
    quantity { 1 }

  end
end
