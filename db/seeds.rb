# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(twitterid: 1465172352) # Andrew's id
Income.create(value: 0)
Income.create(value: 10000)
Income.create(value: 20000)
Income.create(value: 30000)
Income.create(value: 40000)
Income.create(value: 1000000)
Age.create(value: 1985)
Age.create(value: 1986)
Age.create(value: 1990)
Education.create(value: "preschool")
Education.create(value: "post secondary")
Education.create(value: "college")
Education.create(value: "grad")
Education.create(value: "high school")
Gender.create(value: "")
Ethnicity.create(value: "")
Orientation.create(value: "")

UserAnswer.create(user_id: 1, answer_type: "Income", answer_id: 5)
UserAnswer.create(user_id: 1, answer_type: "Age", answer_id: 1)
UserAnswer.create(user_id: 1, answer_type: "Education", answer_id: 2)
UserAnswer.create(user_id: 1, answer_type: "Gender", answer_id: 1)
UserAnswer.create(user_id: 1, answer_type: "Ethnicity", answer_id: 1)
UserAnswer.create(user_id: 1, answer_type: "Orientation", answer_id: 1)