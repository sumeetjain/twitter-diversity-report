class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :fetch_friend_matches, :parse
  
  def parse(user_object_return)
    render :partial => "/results/parse_users_for_view", 
    locals: {:user_array => user_object_return}
  end
  

  
end
