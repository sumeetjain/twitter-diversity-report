class Education < ActiveRecord::Base
  attr_accessible :level_attained
  
  validates :level_attained, presence: true
  validates :level_attained, uniqueness: {case_sensitive: false}
  
  has_and_belongs_to_many :users
end
