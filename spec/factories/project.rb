FactoryBot.define do
  sequence :title do |n|
    "title_#{n}"
  end
  sequence :description do |n|
    "description_#{n}"
  end
  factory :project do
    title
    description
  end
end
