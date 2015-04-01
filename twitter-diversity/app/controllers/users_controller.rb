class UsersController < ApplicationController
  
  before_filter :params_check, only: [:create]
  
  ########### Before Filters #############
  
  def params_check
    
     
    if params["answers"]["education"] == nil
      params["answers"]["education"] = params["education1"]
    end
    
    if params["answers"]["education"] != nil
      params["answers"]["education"].downcase!
      params["answers"]["education"].strip!
    end
    
    if params["answers"]["age"].length != 4
      flash[:age_error] = "Looks like the format for your birth year was incorrect.  Please try again."
      redirect_to "/users/new"
    end 
    
  end 
    
  ########### Route Methods ##############
    
  def new
  end
  
  def create
    education, age, income = params["answers"]["education"], params["answers"]["age"], params["answers"]["income"]
    
    @user = User.create(twitter_handler: session[:screen_name])
    
    if education != nil
      education_id = Education.find_or_create_by_value(education).id
      UserAnswer.create(user_id: @user.id, answer_type: "Education", answer_id: education_id)
    end
    
    if income != nil
      income_id = Income.find_or_create_by_value(income).id
      UserAnswer.create(user_id: @user.id, answer_type: "Income", answer_id: income_id)
    end
    
    if age != nil
      age_id = Age.find_or_create_by_value(age).id
      UserAnswer.create(user_id: @user.id, answer_type: "Age", answer_id: age_id)
    end
    
    if session[:searched_for] == nil
      flash[:message] = "Your information has been added to our files; Any identifying information has been encrypted."
      redirect_to "users/#{session[:username]}"
    else
      redirect_to "user/#{session[:searched_for]}"
    end
  end
  
  def edit
    
  end
  
  def save
    
  end
  
  def delete
    
  end
  
  def view
    
  end
  
end