# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!(
  name: "HR Manager",
  email: "hr@example.com",
  password: "password123",
  password_confirmation: "password123",
  role: :hr
)

User.create!(
  name: "John Doe",
  email: "employee@example.com",
  password: "password123",
  password_confirmation: "password123",
  role: :employee
)
