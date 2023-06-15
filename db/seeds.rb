# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Group.create(name: "Group 1", description: "This is group 1")
Group.create(name: "Group 2", description: "This is group 2")
Group.create(name: "Group 3", description: "This is group 3")

User.create(email: "lukeom@umich.edu", password: "password")
Group.find(1).group_users.create(user_id: 1)
