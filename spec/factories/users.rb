FactoryBot.define do
  sequence :email do |n|
    "user_#{n}@test.com"
  end
  sequence :username do |n|
    "user_#{n}"
  end
  factory :user do
    username
    email
    password { "password" }
  end
end
