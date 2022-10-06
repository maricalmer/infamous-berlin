FactoryBot.define do
  sequence :content do |n|
    "message content #{n}"
  end
  sequence :anchor_id do |n|
    n
  end
  factory :message do
    content
    read_by_receiver { false }
    anchor_id
  end
end
