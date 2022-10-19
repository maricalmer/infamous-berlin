FactoryBot.define do
  sequence :default_position do |n|
    n
  end
  factory :mirror do
    grid_x { nil }
    grid_y { nil }
    grid_h { nil }
    grid_w { nil }
    crop_x { "" }
    crop_y { "" }
    crop_h { "" }
    crop_w { "" }
    default_position
    user
    project
  end
end
