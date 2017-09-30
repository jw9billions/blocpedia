# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(
  email: 'member@blocipedia.com',
  password: 'helloworld',
)

admin = User.create!(
   email:    'admin@example.com',
   password: 'helloworld',
)
admin.role = :admin

5.times do
  User.create!(
    email:    Faker::Internet.email,
    password: Faker::Internet.password(8),
  )
end
users = User.all

#Create Wikis

20.times do
  Wiki.create!(
    title: Faker::Commerce.product_name,
    body: Faker::Company.catch_phrase,
    user: users.sample
  )
end
wikis = Wiki.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
