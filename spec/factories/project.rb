FactoryBot.define do
  sequence :title do |n|
    "title_#{n}"
  end
  sequence :description do |n|
    "description_#{n}"
  end
  factory :project do
    user
    title
    description
    after :build do |project|
      project.attachments.attach(
        io: File.open(Rails.root.join("app", "assets", "images", "logo.png")),
        filename: 'logo.png',
        content_type: "image/png"
      )
    end
  end
end
