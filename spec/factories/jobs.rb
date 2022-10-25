FactoryBot.define do
  factory :job do
    title { "Job title" }
    location { "Mitte" }
    money { 100 }
    skills_needed { "skill" }
    description { "job description" }
    project
    payment { "hourly_rate" }
    status { "open" }
  end
end
