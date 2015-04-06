# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(twitter_handle: "midwestboardgam")
User.create(twitter_handle: "hilarysk")
User.create(twitter_handle: "halfghaninne")
User.create(twitter_handle: "cza_dev")
Income.create(amount: 0)
Income.create(amount: 10000)
Income.create(amount: 20000)
Income.create(amount: 30000)
Income.create(amount: 40000)
Income.create(amount: 1000000)
Age.create(birth_year: 1985)
Age.create(birth_year: 1986)
Age.create(birth_year: 1990)
Education.create(level_attained: "preschool")
Education.create(level_attained: "post secondary")
Education.create(level_attained: "college")
Education.create(level_attained: "grad")
Education.create(level_attained: "high school")

UserAnswer.create(user_id: 1, answer_type: "Income", answer_id: 5)
UserAnswer.create(user_id: 2, answer_type: "Income", answer_id: 6)
UserAnswer.create(user_id: 3, answer_type: "Income", answer_id: 3)
UserAnswer.create(user_id: 4, answer_type: "Income", answer_id: 4)
UserAnswer.create(user_id: 1, answer_type: "Age", answer_id: 1)
UserAnswer.create(user_id: 2, answer_type: "Age", answer_id: 2)
UserAnswer.create(user_id: 3, answer_type: "Age", answer_id: 3)
UserAnswer.create(user_id: 4, answer_type: "Age", answer_id: 2)
UserAnswer.create(user_id: 1, answer_type: "Education", answer_id: 2)
UserAnswer.create(user_id: 2, answer_type: "Education", answer_id: 3)
UserAnswer.create(user_id: 3, answer_type: "Education", answer_id: 4)
UserAnswer.create(user_id: 4, answer_type: "Education", answer_id: 3)
