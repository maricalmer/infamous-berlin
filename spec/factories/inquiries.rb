FactoryBot.define do
  factory :inquiry do
    experience { "great experience" }
    motivation { "great motivation" }
    job
    user
    status { "on_hold" }
  end
end
