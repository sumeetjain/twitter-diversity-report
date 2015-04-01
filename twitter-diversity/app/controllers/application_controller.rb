class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :fetch_friend_matches, :parse
  
  def parse(user_object_return)
      render :partial => "/results/parse_users_for_view", 
      locals: {:user_array => user_object_return}
  end
  
  def fetch_friend_matches(client, searched_twitter_handle)
    
    user_array = []
    
    User.select("twitter_handle").each do |user_object| 
      user_array.push user_object.twitter_handle
    end

    friend_array = client.friends(searched_twitter_handle).to_a

    friend_array.each_with_object([]) do |friend_object, matching_array|
      if user_array.include?(friend_object.screen_name.downcase)
        matching_array.push friend_object
      end
    end
    #matching_array is scoped within this block of code, cannot be accessed outside of it. only accessible right now because it is the final return of the method (and is set equal to a variable in our controller)
  end
  
end
