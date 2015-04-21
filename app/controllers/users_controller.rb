class UsersController < ApplicationController
  
  before_filter :params_check, only: [:save]
  before_filter :validate_user_authorized, except: [:logout]

  
  ########### Before Filters #############
  
  # Need to build in some type of message?
  def validate_user_authorized
    if session[:screen_name] == nil
      redirect_to "/auth/twitter"
    end
  end
  
  def params_check
    education_index = ""
    params["user"]["user_answers_attributes"].each do |x, y|
      if y["answer_type"] == "Education"
        education_index = x
      end
    end

    if params["user"]["user_answers_attributes"][education_index]["value"] == ""
      params["user"]["user_answers_attributes"][education_index]["value"] = params["education1"].downcase
    else
      params["user"]["user_answers_attributes"][education_index]["value"].downcase!
    end
    
  end 
    
  ########### Route Methods ##############
    

  def edit
    @user = User.find_or_create_by_twitterid(session[:twitter_id])
   
    user_answer_types = @user.user_answers.select("distinct answer_type").map { |a| a.answer_type }
   
    all_demos = UserAnswer.answer_types
   
    all_demos.each do |d|
      unless user_answer_types.include?(d)
        @user.user_answers.build(answer_type: d)
      end
    end
       
    @single_answers = @user.user_answers.map {|ua| ua if ua.single_answer_question?}.compact
  end
  

  def save

    #@user = User.find_by_twitter_handle(session[:screen_name].downcase)
    @user = User.find_by_twitterid(session[:twitter_id])
    
    # Add user ID to params, since we don't want users to be able to add it themselves in web inspector.
    params[:user][:user_answers_attributes].each do |k, h|
      h[:user_id] = @user.id
      h[:value] = h[:value]
    end
    
    
    if @user.update_attributes(params[:user]) #kicking up error: Couldn't find UserAnswer with ID=83 for User with ID=15
      flash[:add_message] = "Your information has been updated in our system."

    else 
      flash[:errors] = @user.errors.to_a #add to page as if <ul> loop to show errors
    end

    # if session[:searched_for] == nil
      redirect_to "/users/#{session[:screen_name]}" # viewp page
    # else
    #   result = Result.find_by_searched_handle(session[:searched_for])
    #   redirect_to "/results/#{result.id.to_s}" # To change to results.
    # end
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
  
  def logout
    session.clear
    redirect_to "/"
  end
  
end