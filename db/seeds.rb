# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require "open-uri"

puts "cleaning up DB"
Message.destroy_all if Rails.env.development?
Chatroom.destroy_all if Rails.env.development?
Inquiry.destroy_all if Rails.env.development?
ActiveRecord::Base.connection.reset_pk_sequence!('inquiries')
Job.destroy_all if Rails.env.development?
ActiveRecord::Base.connection.reset_pk_sequence!('jobs')
Collab.destroy_all if Rails.env.development?
ActiveRecord::Base.connection.reset_pk_sequence!('collabs')
Project.destroy_all if Rails.env.development?
ActiveRecord::Base.connection.reset_pk_sequence!('projects')
User.destroy_all if Rails.env.development?
ActiveRecord::Base.connection.reset_pk_sequence!('users')
puts "DB is empty"
puts "-----------"
puts "creating users"
5.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: "123456",
    username: Faker::Internet.unique.username,
    skills: Faker::Job.key_skill.downcase,
    bio: Faker::Lorem.sentence(word_count: rand(5..50)),
    title: Faker::Lorem.sentence(word_count: rand(1..6)),
    confirmed_at: Time.now.utc
  )
  puts "user #{user.id} is created"
end
puts "5 new users"
puts "creating projects"
2.times do
  project = Project.new(
    title: Faker::Book.unique.title,
    description: Faker::Quote.matz,
    category: ['painting', 'print', 'photography', 'sculpture', 'furniture', 'fashion', 'other'].sample,
    date: Faker::Date.in_date_period,
    location: ["Mitte", "P.Berg", "Wedding", "Kreuzberg", "Neukölln", "Friedrichshain"].sample,
    user: User.all.sample
  )
  project.attachments.attach(
    io: URI.open('https://images.unsplash.com/photo-1541961017774-22349e4a1262?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1058&q=80'),
    filename: Faker::File.file_name(ext: 'jpg'),
    content_type: 'image/jpg'
  )
  project.save!
  puts "project #{project.id} is created"
end
puts "2 new projects"
puts "updating upcoming project"
upcoming_project = Project.find(1)
upcoming_project.update(status: "upcoming")
puts "1 project updated to upcoming"
puts "creating 1 job"
project = Project.first
job = Job.create!(
  title: ["video editor", "photographer", "model", "stylist", "designer", "dancer", "musician"].sample,
  skills_needed: ["acting", "dancing", "photoshop"].sample,
  description: Faker::Lorem.sentence(word_count: 5, random_words_to_add: 10),
  location: ["Mitte", "P.Berg", "Wedding", "Kreuzberg", "Neukölln", "Friedrichshain", "remote"].sample,
  payment: ["fixed_rate", "hourly_rate"].sample,
  money: [100, 150, 200, 250, 300, 350].sample,
  status: ["open", "close"].sample,
  project_id: project.id
)
puts "job #{job.id} is created"
puts "1 new job"
puts "creating inquiry"
job = Job.first
user = User.last
inquiry = Inquiry.create!(
  experience: Faker::Lorem.sentence(word_count: 10, random_words_to_add: 10),
  motivation: Faker::Lorem.sentence(word_count: 10, random_words_to_add: 10),
  job_id: job.id,
  user_id: user.id
)
puts "inquiry #{inquiry.id} is created"
puts "1 new inquiry"
puts "-----------"
puts "SEEDING IS DONE!!!"
