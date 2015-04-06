class Age < ActiveRecord::Base
  include ActiveModel::Validations
  
  attr_accessible :value
  
  validates :value, numericality: {only_integer: true}
  validates :value, presence: true  
  validates :value, uniqueness: {case_sensitive: false}
  validates_with YearValidator
  
  has_many :user_answers, as: :answer
end
