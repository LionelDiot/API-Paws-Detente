FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "testpaws#{n}@yopmail.com"  }
    password { "password" }

  end
end
