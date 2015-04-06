class Age < ActiveRecord::Base
  attr_accessible :value
  
  validates :value, numericality: {only_integer: true}
  validates :value, presence: true  
  validates :value, uniqueness: {case_sensitive: false}
  
  has_many :user_answers, as: :answer
end
