require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "123456" }
  end
  
  factory :post do
    user_id { create(:user).id }
    title { Faker::Lorem.word }
    body { "There are five steps involved." }
  end
  
  factory :comment do
    association :post
    association :user
    body { "Great article!" }
  end
end

