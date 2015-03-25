# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Post.destroy_all
Comment.destroy_all 

 require 'faker'
 
 # Create Posts
 50.times do
   Post.where(
     title:  Faker::Lorem.sentence,
     body:   Faker::Lorem.paragraph
   ).first_or_create
 end
 posts = Post.all
 
 # Create Comments
 100.times do
   Comment.where(
     post: posts.sample,
     body: Faker::Lorem.paragraph
   ).first_or_create
 end

 # Seed Data assignment
Post.find_by(title: 'Seed Data Title', body: 'Seed Data Body').first_or_create

Comment.by(body: 'Seed Data Comment', post_id: 1).first_or_create

 
 puts "Seed finished"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"