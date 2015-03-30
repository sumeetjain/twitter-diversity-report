class Income < ActiveRecord::Base
  attr_accessible :amount
  
  validates :amount, presence: true
  validates :amount, uniqueness:  {case_sensitive: false}
  validates :amount, numericality: {only_integer: true}  
 
  has_many :users
    
end
