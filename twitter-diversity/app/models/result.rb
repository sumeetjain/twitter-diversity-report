class Result < ActiveRecord::Base
  attr_accessible :searched_handle, :demo_hash
  
  validates :searched_handle, presence: true
  
end
