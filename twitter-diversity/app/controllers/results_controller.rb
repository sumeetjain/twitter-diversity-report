class ResultsController < ApplicationController
  
  def new
    @twitter_handle = params[:twitter_handle]
    
    #move this eventually#
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = "5yMZJo4VreMP3mMER6LS5Z5j7"  
      config.consumer_secret = "jizR3IdQCUsxfgdEyD9LrnOmw1WHLF3XzPzYq5SAqlfhk0gter"  
    end
    @friend_return = fetch_friend_matches(client, @twitter_handle)
    
    @user_objects_return = []
    
    @friend_return.each do |friend_object|
      search = friend_object.screen_name.downcase
      @user_objects_return << User.find_by_twitter_handle(search)
    end
    
    parse_var = parse(@user_objects_return)
    ￿


  end
  
end
