class User < ActiveRecord::Base
  attr_accessible :twitter_handle, :user_answers_attributes, :twitter_id
  
  validates :twitter_handle, presence: true
  validates :twitter_handle, uniqueness: {case_sensitive: false} 
  
  has_many :ages, through: :user_answers, 
                  source_type: "Age", 
                  source: :answer
                  
  has_many :educations, through: :user_answers,
                        source_type: "Education", 
                        source: :answer
                      
  has_many :incomes, through: :user_answers,
                     source_type: "Income",
                     source: :answer
                    
  has_many :user_answers
  
  accepts_nested_attributes_for :user_answers
end
