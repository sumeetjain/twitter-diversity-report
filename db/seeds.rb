# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(
  twitter_id: 8345082,
  age: 18,
  income: 0,
  education: 'Secondary',
  ethnicities_attributes: [{value: 'white'}],
  genders_attributes: [{value: 'male'}],
  orientations_attributes: [{value: 'homosexual'}]
)

User.create!(
  twitter_id: 89887215,
  age: 25,
  income: 50000,
  education: 'Post-secondary',
  ethnicities_attributes: [{value: 'white'}, {value: 'hispanic'}],
  genders_attributes: [{value: 'female'}],
  orientations_attributes: [{value: 'heterosexual'}]
)

User.create!(
  twitter_id: 93069110,
  age: 28,
  income: 28000,
  education: 'Post-secondary',
  ethnicities_attributes: [{value: 'african american'}],
  genders_attributes: [{value: 'genderqueer'}, {value: 'nonbinary'}],
  orientations_attributes: [{value: 'heterosexual'}]
)

User.create!(
  twitter_id: 44078966,
  age: 34,
  income: 37500,
  education: 'Graduate',
  ethnicities_attributes: [{value: 'asian'}],
  genders_attributes: [{value: 'female'}],
  orientations_attributes: [{value: 'bisexual'}, {value: 'queer'}]
)

User.create!(
  twitter_id: 6723132,
  age: 22,
  income: 120000,
  education: 'Post-graduate',
  ethnicities_attributes: [{value: 'hispanic'}],
  genders_attributes: [{value: 'male'}],
  orientations_attributes: [{value: 'heterosexual'}]
)

User.create!(
  twitter_id: 831898993,
  age: 47,
  income: 83000,
  education: 'Graduate',
  ethnicities_attributes: [{value: 'white'}],
  genders_attributes: [{value: 'female'}],
  orientations_attributes: [{value: 'homosexual'}]
)