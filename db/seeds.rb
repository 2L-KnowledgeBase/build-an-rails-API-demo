# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
	{email: 'test1@cscs.com', name: 'test1', activated: DateTime.now, admin: false},
	{email: 'test2@cscs.com', name: 'test2', activated: DateTime.now, admin: false}
])
