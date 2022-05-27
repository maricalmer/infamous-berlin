# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# SPLASH
# >>> sculpture
# https://unsplash.com/@lauraadaiphoto
# https://unsplash.com/photos/PcjuUQN1mFc
# https://unsplash.com/photos/oSVJYgL0qUs
# https://unsplash.com/photos/4QTRb16OOts
# >>> modern art
# https://unsplash.com/photos/_8zO0LaCxRQ
# https://unsplash.com/photos/h2uCymK1oYc
# https://unsplash.com/photos/ZZTbCMOWAGk
# >>> profile pic
# https://unsplash.com/photos/3TLl_97HNJo

# PEXELS
# >>> login (P.Berg)
# https://www.pexels.com/video/a-man-lovingly-touching-the-face-of-a-head-bust-sculpture-3712948/
# https://www.pexels.com/video/painting-one-s-face-with-black-4788417/
# https://www.pexels.com/video/fashion-woman-art-model-4962903/
# https://www.pexels.com/video/a-man-playing-the-piano-while-a-woman-playing-the-guitar-while-singing-8039634/
# https://www.pexels.com/video/a-rapper-recording-in-a-studio-8132052/
# https://www.pexels.com/video/painting-one-s-face-with-black-4788417/


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
puts "collabs..."
Collab.destroy_all if Rails.env.development?
ActiveRecord::Base.connection.reset_pk_sequence!('collabs')
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
    skills: Faker::Job.key_skill.downcase,
    bio: Faker::Lorem.sentence(word_count: rand(5..50)),
    title: Faker::Lorem.sentence(word_count: rand(1..6))
  )
  user.update(website: "thewebsite.com") if rand(1..2) == 1
  user.update(facebook: "facebook-account-url.com") if rand(1..2) == 1
  user.update(instagram: "instagram-account-url.com") if rand(1..2) == 1
  user.update(soundcloud: "soundcloud-account-url.com") if rand(1..2) == 1
  user.update(youtube: "youtube-account-url.com") if rand(1..2) == 1
  user.update(mixcloud: "mixcloud-account-url.com") if rand(1..2) == 1
  user.update(linkedin: "linkedin-account-url.com") if rand(1..2) == 1
  user.update(twitter: "twitter-account-url.com") if rand(1..2) == 1
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
    user: User.all.sample
  )
  project.attachments.attach(
    io: URI.open('https://res.cloudinary.com/dbpv82leg/image/upload/v1600074118/w54i1yub1kgz5rvd22i0c5wr4pwm.jpg'),
    filename: Faker::File.file_name(ext: 'jpg'),
    content_type: 'image/jpg'
  )
  project.attachments.attach(
    io: URI.open('https://res.cloudinary.com/dbpv82leg/image/upload/v1598882767/wfauj0r0q92zxqxs6lpp.jpg'),
    filename: Faker::File.file_name(ext: 'jpg'),
    content_type: 'image/jpg'
  )
  project.attachments.attach(
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
puts "creating 1 message"
chatroom = Chatroom.create!(
  author: User.first,
  receiver: Project.first.user
)
message = Message.create!(
  content: "Test message from #{Time.now} - [seeds]",
  anchor_id: 1,
  read_by_receiver: false,
  chatroom: chatroom,
  user: User.first
)
puts "creating collabs"
projects = Project.first(15)
users = User.first(15)
10.times do
  members = users - [projects.first.user]
  collab = Collab.create!(
    project: projects.first,
    member: members.sample
  )
  projects.delete(projects.first)
  puts "collab #{collab.id} is created"
end
puts "10 fresh new collabs"
puts "creating jobs"
projects = Project.first(10)
10.times do
  job = Job.create!(
    title: ["video editor", "photographer", "model", "stylist", "designer", "dancer", "musician"].sample,
    skills_needed: ["acting", "dancing", "photoshop"].sample,
    description: Faker::Lorem.sentence(word_count: 5, random_words_to_add: 10),
    location: ["Mitte", "P.Berg", "Wedding", "Kreuzberg", "Neukölln", "Friedrichshain", "remote"].sample,
    payment: ["fixed_rate", "hourly_rate"].sample,
    status: ["open", "close"].sample,
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
    experience: Faker::Lorem.sentence(word_count: 10, random_words_to_add: 10),
    motivation: Faker::Lorem.sentence(word_count: 10, random_words_to_add: 10),
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
