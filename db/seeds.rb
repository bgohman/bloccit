# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Post.destroy_all
Comment.destroy_all
Advertisement.destroy_all
Question.destroy_all
User.destroy_all
Topic.destroy_all 

 require 'faker'

# Create Users
5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

 # Create Topics
 15.times do
  Topic.create!(
    name:        Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph
  )
 end
 topics = Topic.all
 
 # Create Posts and Ads
 10.times do
    5.times do
      Post.create!(
        user:   users.sample,
        topic:  topics.sample,
        title:  Faker::Lorem.sentence,
        body:   Faker::Lorem.paragraph
      )
    end
    Advertisement.create!(
      topic: topics.sample,
      title: Faker::Lorem.sentence,
      copy:  Faker::Lorem.paragraph,
      price: rand(100)
    )
 end
 posts = Post.all
 
 # Create Comments
 100.times do
   Comment.create!(
     user: users.sample,
     post: posts.sample,
     body: Faker::Lorem.paragraph
   )
 end



# Create Questions
 10.times do
   Question.create!(
     user: users.sample,
     post: posts.sample,
     body: Faker::Lorem.paragraph,
     resolved: false
   )
 end

 # Seed Data assignment
Post.where(user: users.sample, title: 'Seed Data Title', body: 'Seed Data Body').first_or_create

Comment.where(body: 'Seed Data Comment', post_id: 1).first_or_create

# Create an admin
admin = User.new(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)
admin.skip_confirmation!
admin.save!

# Create a moderator
moderator = User.new(
  name:     'Moderator User',
  email:    'moderator@example.com',
  password: 'helloworld',
  role:     'moderator'
)
moderator.skip_confirmation!
moderator.save!

# Create a member
member = User.new(
  name:     'Member User',
  email:    'member@example.com',
  password: 'helloworld',
  role:     'member'
)
member.skip_confirmation!
member.save!

 
 puts "Seed finished"
 puts "#{Topic.count} topics created"
 puts "#{User.count} users created"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"
 puts "#{Advertisement.count} advertisements created"
 puts "#{Question.count} questions created"