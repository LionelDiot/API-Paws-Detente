FactoryBot.define do
  factory :order do
    user { FactoryBot.create(:user) }  
    sequence(:total) { |n| n*100 }
  end
end
