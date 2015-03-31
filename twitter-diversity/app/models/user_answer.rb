class UserAnswer < ActiveRecord::Base
  attr_accessible :user_id, :answer_id, :answer_type
  
  belongs_to :answer, polymorphic: true
  
  belongs_to :user
  
end
