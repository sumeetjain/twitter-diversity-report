class User < ActiveRecord::Base
  attr_accessible :user_answers_attributes, :twitterid
  
  #validates :twitter_handle, presence: true
  validates :twitterid, presence: true
  
  has_many :ages, through: :user_answers, 
                  source_type: "Age", 
                  source: :answer
                  
  has_many :educations, through: :user_answers,
                        source_type: "Education", 
                        source: :answer
                      
  has_many :incomes, through: :user_answers,
                     source_type: "Income",
                     source: :answer
                     
  has_many :genders, through: :user_answers,
                    source_type: "Gender",
                    source: :answer

  has_many :orientations, through: :user_answers,
                     source_type: "Orientation",
                     source: :answer
  
  
  has_many :ethnicities, through: :user_answers,
                    source_type: "Ethnicity",
                    source: :answer
  
  has_many :user_answers
  
  accepts_nested_attributes_for :user_answers
end
