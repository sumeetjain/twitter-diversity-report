class User < ActiveRecord::Base
  attr_accessible :user_answers_attributes, :twitterid, :ethnicities_text_area, :genders_text_area, :orientations_text_area, :encrypted_id
  
  validates :ethnicities_text_area, length: {maximum: 20}
  
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

  #################### BCRYPT METHODS ##################################
  
  include BCrypt

    def encrypted_id
      @encrypted_id ||= Password.new(twitterid)
    end

    def encrypted_id=(new_password)
      @encrypted_id = Password.create(new_password)
      self.twitterid = @encrypted_id
    end


  ################### ETHNICITY METHODS ##############################
  
  # Returns ethnicity values for this user as an Array.
  def ethnicities_as_array
    ethnicities.map do |g|
      g.value
    end
  end
  
  def ethnicities_text_area
    ethnicities_as_array.join("\r\n")
  end
  
  def ethnicities_text_area=(text_from_form_field) #pull out method body into separate private method below and then call for each setter for respecitve categories
    self.ethnicities.delete_all
    
    users_inputs_array = text_from_form_field.split("\r\n")
    
    users_inputs_array.each do |e|
      if !self.ethnicities_as_array.include?(e)
        self.ethnicities << Ethnicity.find_or_create_by_value(e)
      end
    end
  end

  ################### GENDER METHODS ##############################
  
  # Returns gender values for this user as an Array.
  def genders_as_array
    genders.map do |g|
      g.value
    end
  end
  
  def genders_text_area
    genders_as_array.join("\r\n")
  end
  
  def genders_text_area=(text_from_form_field) #pull out method body into separate private method below and then call for each setter for respecitve categories
    self.genders.delete_all
    
    users_inputs_array = text_from_form_field.split("\r\n")
    
    users_inputs_array.each do |e|
      if !self.genders_as_array.include?(e)
        self.genders << Gender.find_or_create_by_value(e)
      end
    end
  end

  ################### ORIENTATION METHODS ##############################
  
  # Returns orientation values for this user as an Array.
  def orientations_as_array
    orientations.map do |g|
      g.value
    end
  end
  
  def orientations_text_area
    orientations_as_array.join("\r\n")
  end
  
  def orientations_text_area=(text_from_form_field) #pull out method body into separate private method below and then call for each setter for respecitve categories
    self.orientations.delete_all
    
    users_inputs_array = text_from_form_field.split("\r\n")
    
    users_inputs_array.each do |e|
      if !self.orientations_as_array.include?(e)
        self.orientations << Orientation.find_or_create_by_value(e)
      end
    end
  end

end
