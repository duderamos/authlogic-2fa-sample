# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create!(
  email:                 'admin@example.com',
  first_name:            'admin',
  last_name:             'system',
  password:              'supersecret',
  password_confirmation: 'supersecret',
  two_factor_secret:     'v6nasf4kfe45qxbq'
)

puts 'Created `admin` user:'
puts "Email:    #{user.email}"
puts "Password: #{user.password}"
puts
puts "Google Authenticator time based two_factor_secret (spaces optional): #{user.two_factor_secret.scan(/.{4}/).join(' ')}"
puts
