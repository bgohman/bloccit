# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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

 # Seed Data assignment
Post.find_or_create_by(title: 'Seed Data Title')
unique_seed = Post.find_by(title: 'Seed Data Title')
unique_seed.update(body: 'Seed Data Body')

Comment.find_or_create_by(body: 'Seed Data Comment')
unique_comment = Comment.find_by(body: 'Seed Data Comment')
unique_comment.update(post_id: 1)

 
 puts "Seed finished"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"