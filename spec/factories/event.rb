FactoryBot.define do
  factory :event do
    title
    description
    date { DateTime.now }
  end
end

