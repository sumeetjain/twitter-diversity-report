class User < ActiveRecord::Base
  attr_accessible :twitter_handle
  
  validates :twitter_handle, presence: true
  validates :twitter_handle, uniqueness: {case_sensitive: false} 
  
  has_one :age
  has_one :education
  has_one :income
end
