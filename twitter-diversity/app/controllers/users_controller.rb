class UsersController < ApplicationController
  
  before_filter :params_check, only: [:create]
  before_filter :validate_user_authorized

  
  ########### Before Filters #############
  
  # Need to build in some type of message?
  def validate_user_authorized
    if session[:screen_name] == nil
      redirect_to "/auth/twitter"
    end
  end
  
  def params_check
    
     
    if params["answers"]["education"] == ""
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
    

  def edit
    @user = User.find_or_create_by_twitter_handle(session[:screen_name].downcase)
    @user.user_answers.build(answer_type: "Education")

    @user.user_answers.build(answer_type: "Age")
    @user.user_answers.build(answer_type: "Income")
  end
  

  def save

    @user = User.find_by_twitter_handle(session[:screen_name].downcase)
    
    # Add user ID to params, since we don't want users to be able to add it themselves in web inspector.
    params[:user][:user_answers_attributes].each do |k, h|
      h[:user_id] = @user.id
    end
    
    @user.update_attributes(params[:user])
    
    # find_or_create_if_not_nil(params["answers"])
    
    flash[:message] = "Your information has been added to our files; Any identifying information has been encrypted."
    
    if session[:searched_for] == nil
      redirect_to "/users/#{session[:username]}" # To change to results.
    else
      redirect_to "/user/#{session[:searched_for]}" # To change to results.
    end
  end
  
  # def edit
#     @user = User.find_by_twitter_handle(session[:screen_name].downcase)
#     @answers = return_all_user_answers(@user.id) #maybe dont' need bc rails handles? esp. if we make same route as new
#   end
#
#   def save
#     @user = User.find(params[:id])
#
#     # Add user ID to params, since we don't want users to be able to add it themselves in web inspector.
#     params[:user][:user_answers_attributes].each do |k, h|
#       h[:user_id] = @user.id
#     end
#
#     binding.pry
#
#     @user.update_attributes(params[:user])
#
#     # find_or_create_if_not_nil(params["answers"])
#
#     flash[:message] = "Your information has been added to our files; Any identifying information has been encrypted."
#
#     if session[:searched_for] == nil
#       redirect_to "/users/#{session[:username]}" # To change to results.
#     else
#       redirect_to "/user/#{session[:searched_for]}" # To change to results.
#     end
#   end
#
  def delete    
    user = User.find_by_twitter_handle(session[:screen_name].downcase)
    
    UserAnswer.delete_all(["user_id = ?", user.id])
    
    user.destroy
    
    flash[:message] = "Your information was successfully removed from the system."
    
    session.clear
    
    redirect_to "/"

    
  end
  
  def view
    @user = User.find_by_twitter_handle(session[:screen_name].downcase)
  end
  
  private
  
  def return_all_user_answers(id)
    answer_array = UserAnswer.where(user_id: id)
    return_answer_hash = {}
    answer_array.each do |answer|
      return_answer_hash[answer.answer_type] = answer.answer_type.constantize.find(answer.answer_id).value
    end
    return_answer_hash
  end
  
  def find_or_create_if_not_nil(variable_hash)
    variable_hash.each do |klass, value|
      if value != nil
        id = (klass.to_s.capitalize.constantize).find_or_create_by_value(value).id
        UserAnswer.create(user_id: @user.id, answer_type: klass.capitalize, answer_id: id)
      end
    end
  end
  
end