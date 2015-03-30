class Result < ActiveRecord::Base
  attr_accessible :searched_handle, :education, :income, :age
  
  validates :searched_handle, presence: true
  
end
