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
    
  end
  
  def test
    require 'json'
    
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = "5yMZJo4VreMP3mMER6LS5Z5j7"  
      config.consumer_secret = "jizR3IdQCUsxfgdEyD9LrnOmw1WHLF3XzPzYq5SAqlfhk0gter"  
    end
    
    user_array = []
    
    User.select("twitter_handle").each do |user_object| 
      user_array.push user_object.twitter_handle
    end

    searched_twitter_handle = "cza_dev"

    friend_array = client.friends(searched_twitter_handle).to_a
    
    matching_array = []

    friend_array.each do |friend_object|
      if user_array.include?(friend_object.screen_name.downcase)
        matching_array.push friend_object
      end
    end
    
    # # User.select("twitter_handle").each_with_object([]) do |user_object, user_array|
    # #   user_array.push user_object.twitter_handle
    # # end
    #
    # friend_array = client.friends(searched_twitter_handle).to_a
    #
    # friend_array.each_with_object([]) do |friend_object, matching_array|
    #   if user_array.include?(friend_object.screen_name.downcase)
    #     matching_array.push friend_object
    #   end
    # end

    friend_answers = []
    matching_array.each do |friend_object|
      matched_user = User.find_by_twitter_handle(friend_object.screen_name.downcase)
      friend_answers += matched_user.user_answers
    end
    
    demographics = []
    friend_answers.each do |a|
      unless demographics.include?(a.answer_type)
        demographics.push a.answer_type
      end
    end
    
    demo_hash = {}
    
    demographics.each do |d|
      demo_answers = []
      friend_answers.each do |a|
        if a.answer_type == d
          demo_answers.push a
        end
      end
      
      unique_ans = []
      
      demo_answers.each do |a|
        unless unique_ans.include?(a.answer_id)
          unique_ans.push a.answer_id
        end
      end
      
      slice_hash = {}
      
      unique_ans.each do |a|
        count = demo_answers.count{|b| b.answer_id == a}
        answer = d.constantize.find(a).value
        slice_hash[answer] = count
      end
      
      demo_hash[d] = slice_hash
      
    end
    
    
    #demo_hash = {"Income"=>{40000=>1, 20000=>1}, "Age"=>{1985=>1, 1990=>1}, "Education"=>{"secondary"=>1, "graduate"=>1}}
    @edu_chart_data = [["Level Attained", "Count"]]
    demo_hash["Education"].each do |k,v|
      @edu_chart_data.push [k,v]
    end
    
    
  end
  
end
