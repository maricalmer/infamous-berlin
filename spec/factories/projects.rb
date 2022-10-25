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
        io: File.open(Rails.root.join("spec", "fixtures", "files", "img_sample.jpeg")),
        filename: 'img_sample.jpeg',
        content_type: "image/jpeg"
      )
    end
  end
end
