class UserAnswer < ActiveRecord::Base
  attr_accessible :user_id, :answer_id, :answer_type, :value
  
  belongs_to :answer, polymorphic: true
  
  belongs_to :user
  
  # accepts_nested_attributes_for :answer
  
  def field_value
    self.answer_type
  end
  
  def value
    self.answer.value if self.answer
  end
  
  def value=(form_value)
    binding.pry
    answer_object = self.answer_type.constantize.find_or_create_by_value(form_value)
    self.answer_id = answer_object.id
  end
  
end
