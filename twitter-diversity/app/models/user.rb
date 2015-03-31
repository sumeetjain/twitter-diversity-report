class User < ActiveRecord::Base
  attr_accessible :twitter_handle, :age
  
  validates :twitter_handle, presence: true
  validates :twitter_handle, uniqueness: {case_sensitive: false} 
  
  has_and_belongs_to_many :age
  has_and_belongs_to_many :education
  has_and_belongs_to_many :income
  
  def set_age
    if 
      
    else
    end
  end
  
end
