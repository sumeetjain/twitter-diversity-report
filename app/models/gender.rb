class Gender < ActiveRecord::Base
  attr_accessible :value
  
  validates :value, presence: true  
  validates :value, uniqueness: {case_sensitive: false}
  
  has_many :user_answers, as: :answer
end
