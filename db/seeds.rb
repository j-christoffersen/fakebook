# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

rick = User.create!(name:  "Rick Sanchez",
             email: "rs@example.org",
             password:              "foobar",
             password_confirmation: "foobar")
             
morty = User.create!(name:  "Morty Smith",
             email: "ms@example.org",
             password:              "foobar",
             password_confirmation: "foobar")
             
poopy = User.create!(name:  "Mr. Poopy Butthole",
             email: "mpb@example.org",
             password:              "foobar",
             password_confirmation: "foobar")
             
19.times do |i|
  User.create!(name:  "User #{i}",
             email: "user-#{i}@example.org",
             password:              "foobar",
             password_confirmation: "foobar")
end

rick.add_friend morty
morty.add_friend rick
rick.add_friend poopy
poopy.add_friend rick
morty.add_friend poopy
poopy.add_friend morty

rick.posts.create!(body: "Wubalubadubdub!!!")
poopy.posts.create!(body: "ooooh weeeeeeee")