class User < ActiveRecord::Base
  attr_accessible :twitter_handle
  
  validates :twitter_handle, presence: true
  validates :twitter_handle, uniqueness: {case_sensitive: false} 
  
  has_one :age, :education, :income
  
end
