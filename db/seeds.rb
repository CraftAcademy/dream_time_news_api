# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'journalist@mail.com', password: 'password', role: 'journalist')
5.times {Article.create(title: 'Covid', sub_title: 'Covid 19', content: 'Covid coming', author_id: 1)}