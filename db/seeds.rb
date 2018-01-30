# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.where(email: "test@test.com").first_or_create do |u|
  u.admin                 = true
  u.organisation_name     = "UNEP WCMC"
  u.username              = "Informatics"
  u.password              = "test1234"
  u.password_confirmation = "test1234"

  puts "Admin created! \nU: test@test.com\nP: test1234"
end

