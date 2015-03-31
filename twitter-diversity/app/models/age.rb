class Age < ActiveRecord::Base
  attr_accessible :birth_year
  
  validates :birth_year, numericality: {only_integer: true}
  validates :birth_year, presence: true  
  validates :birth_year, uniqueness: {case_sensitive: false}
  
  has_many :user_answers, as: :answer
end
