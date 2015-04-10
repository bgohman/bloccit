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

 require 'faker'
 
 # Create Posts
 50.times do
   Post.create!(
     title:  Faker::Lorem.sentence,
     body:   Faker::Lorem.paragraph
   )
 end
 posts = Post.all
 
 # Create Comments
 100.times do
   Comment.create!(
     post: posts.sample,
     body: Faker::Lorem.paragraph
   )
 end

  # Create Ads
 10.times do
   Advertisement.create!(
     title: Faker::Lorem.sentence,
     copy: Faker::Lorem.paragraph,
     price: rand(100)
   )
 end

# Create Questions
 10.times do
   Question.create!(
     title: Faker::Lorem.sentence,
     body: Faker::Lorem.paragraph,
     resolved: false
   )
 end

 # Seed Data assignment
Post.where(title: 'Seed Data Title', body: 'Seed Data Body').first_or_create

Comment.where(body: 'Seed Data Comment', post_id: 1).first_or_create

 
 puts "Seed finished"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"
 puts "#{Advertisement.count} advertisements created"
 puts "#{Question.count} questions created"