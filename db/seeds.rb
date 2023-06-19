# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
Item.destroy_all
User.destroy_all


ActiveRecord::Base.connection.execute('ALTER SEQUENCE items_id_seq RESTART WITH 1')
ActiveRecord::Base.connection.execute('ALTER SEQUENCE users_id_seq RESTART WITH 1')
# Create a user
user = User.create!(
  email: 'admin@admin.fr',
  password: 'password'
)

# Create articles associated with the user
10.times do
  user.articles.create!(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Commerce.price,
    image_url: "https://loremflickr.com/320/240?lock=#{rand(1..1000)}"
  )
end

puts 'Seed réussi!'