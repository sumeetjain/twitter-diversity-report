# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(
  twitter_id: 1,
  age: 18,
  income: 0,
  education: 'high school degree',
  ethnicities_attributes: [{value: 'white'}],
  genders_attributes: [{value: 'male'}],
  orientation: 'homosexual'
)

User.create(
  twitter_id: 2,
  age: 25,
  income: 50000,
  education: 'college degree',
  ethnicities_attributes: [{value: 'white'}, {value: 'hispanic'}],
  genders_attributes: [{value: 'female'}],
  orientation: 'heterosexual'
)

User.create(
  twitter_id: 3,
  age: 28,
  income: 28000,
  education: 'college degree',
  ethnicities_attributes: [{value: 'african american'}],
  genders_attributes: [{value: 'genderqueer'}, {value: 'nonbinary'}],
  orientation: 'heterosexual'
)

User.create(
  twitter_id: 4,
  age: 34,
  income: 37500,
  education: 'graduate degree',
  ethnicities_attributes: [{value: 'asian'}],
  genders_attributes: [{value: 'female'}],
  orientation: 'bisexual'
)

User.create(
  twitter_id: 5,
  age: 22,
  income: 120000,
  education: 'some college',
  ethnicities_attributes: [{value: 'hispanic'}],
  genders_attributes: [{value: 'male'}],
  orientation: 'heterosexual'
)

User.create(
  twitter_id: 6,
  age: 47,
  income: 83000,
  education: 'graduate degree',
  ethnicities_attributes: [{value: 'white'}],
  genders_attributes: [{value: 'female'}],
  orientation: 'homosexual'
)