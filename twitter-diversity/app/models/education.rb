class Education < ActiveRecord::Base
  attr_accessible :level_attained
  
  validates :level_attained, presence: true
  
end
