# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"

puts "cleaning up DB"
puts "messages..."
Message.destroy_all if Rails.env.development?
puts "chatrooms..."
Chatroom.destroy_all if Rails.env.development?
puts "inquiries..."
Inquiry.destroy_all if Rails.env.development?
ActiveRecord::Base.connection.reset_pk_sequence!('inquiries')
puts "jobs..."
Job.destroy_all if Rails.env.development?
ActiveRecord::Base.connection.reset_pk_sequence!('jobs')
puts "projects..."
Project.destroy_all if Rails.env.development?
ActiveRecord::Base.connection.reset_pk_sequence!('projects')
puts "users..."
User.destroy_all if Rails.env.development?
ActiveRecord::Base.connection.reset_pk_sequence!('users')
puts "DB is empty"
puts "-----------"
puts "creating users"
20.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: "123456",
    username: Faker::Internet.unique.username,
    skills: [Faker::Job.key_skill],
    bio: Faker::GreekPhilosophers.quote,
  )
  user.update(socialmedias: [ "@" + user.username ])
  user.photo.attach(
    io: URI.open('https://res.cloudinary.com/dbpv82leg/image/upload/v1624021222/photo-1522075469751-3a6694fb2f61.jpg'),
    filename: Faker::File.file_name(ext: 'jpg'),
    content_type: 'image/jpg'
    )
  puts "user #{user.id} is created"
end
puts "20 fresh new users"
puts "creating projects"
20.times do
  project = Project.create!(
    title: Faker::Book.unique.title,
    description: Faker::Quote.matz,
    category: [['painting', 'print', 'photography', 'sculpture', 'furniture', 'fashion', 'other'].sample],
    date: Faker::Date.in_date_period,
    location: ["Mitte", "P.Berg", "Wedding", "Kreuzberg", "Neukölln", "Friedrichshain"].sample,
    user: User.all.sample,
  )
  other_users = User.all.where.not(id: project.user_id)
  project.update(member: [ "@" + other_users.sample.username ])
  project.photos.attach(
    io: URI.open('https://res.cloudinary.com/dbpv82leg/image/upload/v1600074118/w54i1yub1kgz5rvd22i0c5wr4pwm.jpg'),
    filename: Faker::File.file_name(ext: 'jpg'),
    content_type: 'image/jpg'
  )
  project.photos.attach(
    io: URI.open('https://res.cloudinary.com/dbpv82leg/image/upload/v1598882767/wfauj0r0q92zxqxs6lpp.jpg'),
    filename: Faker::File.file_name(ext: 'jpg'),
    content_type: 'image/jpg'
  )
  project.photos.attach(
    io: URI.open('https://res.cloudinary.com/dbpv82leg/image/upload/v1598882740/rbhbfgjs12fnd3krfy0i.jpg'),
    filename: Faker::File.file_name(ext: 'jpg'),
    content_type: 'image/jpg'
  )
  puts "project #{project.id} is created"
end
puts "20 fresh new projects"
puts "updating upcoming projects"
upcoming_projects = Project.find([10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])
upcoming_projects.each do |project|
  project.update(status: "upcoming")
end
puts "10 upcoming projects updated"
puts "creating jobs"
projects = Project.first(10)
10.times do
  job = Job.create!(
    deadline: rand(2..4).weeks.from_now,
    start_date: rand(4..6).days.from_now,
    end_date: rand(7..9).days.from_now,
    title: ["video editor", "photographer", "model", "stylist", "designer", "dancer", "musician"].sample,
    skills_needed: ["acting", "dancing", "photoshop"].sample,
    description: Faker::Lorem.sentence(word_count: 5, random_words_to_add: 10),
    project_id: projects.first.id
  )
  projects.delete(projects.first)
  puts "job #{job.id} is created"
end
puts "10 fresh new jobs"
puts "creating inquiries"
jobs = Job.first(10)
users = User.first(10)
10.times do
  inquiry = Inquiry.create!(
    text: Faker::Lorem.sentence(word_count: 10, random_words_to_add: 10),
    job_id: jobs.first.id,
    user_id: users.first.id == jobs.first.project.user.id ? users.last.id : users.first.id
  )
  jobs.delete(inquiry.job)
  users.delete(inquiry.user)
  puts "inquiry #{inquiry.id} is created"
end
puts "10 fresh new inquiries"
puts "-----------"
puts "SEEDING IS DONE!!!"
