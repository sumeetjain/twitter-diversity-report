class UsersController < ApplicationController
  
  before_filter :params_check, only: [:save]
  before_filter :validate_user_authorized

  
  ########### Before Filters #############
  
  # Need to build in some type of message?
  def validate_user_authorized
    if session[:screen_name] == nil
      redirect_to "/auth/twitter"
    end
  end
  
  def params_check
    binding.pry
    education_index = ""
    params["user"]["user_answers_attributes"].each do |x, y|
      if y["answer_type"] == "Education"
        education_index = x
      end
    end
    
    #makes array of strings of each gender entry
    params["user"]["user_answers_attributes"].each do |x, y|
      if y["answer_type"] == "Gender"
        @gender_array = y["value"].split("\r\n")
      end
    end
    
    #removes gender entry from array
    params["user"]["user_answers_attributes"].delete_if do |x, y|
      y["answer_type"] == "Gender" && y["value"].include?("\r\n")
    end
    
    
    #will need to tweak for multiple ethnicites/orientations - just a test for now
    num = params["user"]["user_answers_attributes"].keys.last.to_i

    @gender_array.each do |gender|
        num += 1
        params["user"]["user_answers_attributes"]["#{num.to_s}"] = {"answer_type"=>"Gender", "value"=>"#{gender.to_s}"}
    end
    
    # Works, but gets messed up right now because of how repopulates the edit form. I think once I make that reconcatenate, it 'll work fine. 
    
    if params["user"]["user_answers_attributes"][education_index]["value"] == ""
      params["user"]["user_answers_attributes"][education_index]["value"] = params["education1"]
    end
    
  end 
    
  ########### Route Methods ##############
    

  def edit

    @user = User.find_or_create_by_twitterid(session[:twitter_id])
    
    user_answer_types = @user.user_answers.select("distinct answer_type")
    
    all_demos = UserAnswer.select("distinct answer_type").map{ |a| a.answer_type }
        
    if @user.user_answers == []
      @user.user_answers.build(answer_type: "Education")
      @user.user_answers.build(answer_type: "Age")
      @user.user_answers.build(answer_type: "Income")
      @user.user_answers.build(answer_type: "Gender")
      @user.user_answers.build(answer_type: "Ethnicity")
      @user.user_answers.build(answer_type: "Orientation")
    end
    
  end
  

  def save

    #@user = User.find_by_twitter_handle(session[:screen_name].downcase)
    @user = User.find_by_twitterid(session[:twitter_id])
    
    # Add user ID to params, since we don't want users to be able to add it themselves in web inspector.
    params[:user][:user_answers_attributes].each do |k, h|
      h[:user_id] = @user.id
    end
    
    @user.update_attributes(params[:user])
      
    flash[:message] = "Your information has been added to our files; Any identifying information has been encrypted."

    if session[:searched_for] == nil
      redirect_to "/users/#{session[:screen_name]}" # To change to results.
    else
      redirect_to "/users/#{session[:searched_for]}" # To change to results.
    end
  end

  def delete    
    #user = User.find_by_twitter_handle(session[:screen_name].downcase)
    user = User.find_by_twitterid(session[:twitter_id])
    
    UserAnswer.delete_all(["user_id = ?", user.id])
    
    user.destroy
    
    flash[:message] = "Your information was successfully removed from the system."
    
    session.clear
    
    redirect_to "/"

    
  end
  
  def view
    #@user = User.find_by_twitter_handle(session[:screen_name].downcase)
    @user = User.find_by_twitterid(session[:twitter_id])
  end
  
end