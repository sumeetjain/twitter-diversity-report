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
    education_index = ""
    params["user"]["user_answers_attributes"].each do |x, y|
      if y["answer_type"] == "Education"
        education_index = x
      end
    end

    if params["user"]["user_answers_attributes"][education_index]["value"] == ""
      params["user"]["user_answers_attributes"][education_index]["value"] = params["education1"]
    end
    
  end 
    
  ########### Route Methods ##############
    

  def edit
    
    @user = User.find_or_create_by_twitterid(session[:twitter_id])
   
       user_answer_types = @user.user_answers.select("distinct answer_type").map { |a| a.answer_type }
   
       all_demos = UserAnswer.select("distinct answer_type").map{ |a| a.answer_type }
   
       all_demos.each do |d|
         unless user_answer_types.include?(d)
           @user.user_answers.build(answer_type: d)
         end
       end
  end
  

  def save

    #@user = User.find_by_twitter_handle(session[:screen_name].downcase)
    @user = User.find_by_twitterid(session[:twitter_id])
    
    # Add user ID to params, since we don't want users to be able to add it themselves in web inspector.
    
    params[:user][:user_answers_attributes].each do |k, h|
      h[:user_id] = @user.id
    end
    
    
    if @user.update_attributes(params[:user]) #kicking up error: Couldn't find UserAnswer with ID=83 for User with ID=15
      flash[:message] = "Your information has been added to our files; Any identifying information has been encrypted."
    else 
      flash[:errors] = @user.errors.to_a #add to page as if <ul> loop to show errors
    end

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