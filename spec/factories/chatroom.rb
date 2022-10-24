FactoryBot.define do
  factory :chatroom do
    author factory: :user
    receiver factory: :user
  end
end
