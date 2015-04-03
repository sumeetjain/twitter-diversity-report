class ResultsController < ApplicationController
  
  def current
  end
  
  def create
    @twitter_handle = params[:searched_twitter_handle]
    
    client = Result.client
    
    result = Result.create(searched_handle: @twitter_handle,
                        demo_hash: Result.build_result_hash(client, @twitter_handle))
    
    binding.pry
    
    redirect_to "/results/#{result.id}"
    
    # some kind of clear session call  
  end
  
  def view
    binding.pry
    @result = Result.find(params[:id])  
    @demo_hash = @result.demo_hash
  end
  
  
  
  # def new
  #   @twitter_handle = params[:twitter_handle]
  #
  #   #move this eventually#
  #   client = Twitter::REST::Client.new do |config|
  #     config.consumer_key = "5yMZJo4VreMP3mMER6LS5Z5j7"
  #     config.consumer_secret = "jizR3IdQCUsxfgdEyD9LrnOmw1WHLF3XzPzYq5SAqlfhk0gter"
  #   end
  #   @friend_return = fetch_friend_matches(client, @twitter_handle)
  #
  #   @user_objects_return = []
  #
  #   @friend_return.each do |friend_object|
  #     search = friend_object.screen_name.downcase
  #     @user_objects_return << User.find_by_twitter_handle(search)
  #   end
  #
  #   parse_var = parse(@user_objects_return)
  #
  # end
  
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
    # @edu_chart_data = [["Level Attained", "Count"]]
#     demo_hash["Education"].each do |k,v|
#       @edu_chart_data.push [k,v]
#     end
#
#     # consider changing to income_brackets * not buckets?
#
#     income_buckets = [["Under 15000", 0],["15000 - 25000", 0],["25000 - 35000", 0],
#                       ["35000 - 50000", 0],["50000 - 75000", 0],["75000 - 100000", 0],
#                       ["100000 - 150000", 0],["Over 150000", 0]]
#
#     demo_hash["Income"].each do |amount,count|
#       if amount < 15000
#         income_buckets[0][1] += count
#       elsif amount >= 15000 && amount < 25000
#         income_buckets[1][1] += count
#       elsif amount >= 25000 && amount < 35000
#         income_buckets[2][1] += count
#       elsif amount >= 35000 && amount < 50000
#         income_buckets[3][1] += count
#       elsif amount >= 50000 && amount < 75000
#         income_buckets[4][1] += count
#       elsif amount >= 75000 && amount < 100000
#         income_buckets[5][1] += count
#       elsif amount >= 100000 && amount < 150000
#         income_buckets[6][1] += count
#       elsif amount >= 150000
#         income_buckets[7][1] += count
#       end
#     end
#
#     @income_chart_data = [["Income", "Count"]]
#     income_buckets.each{ |b| @income_chart_data.push b }
#
#     # same - brackets not buckets?
#
#     age_buckets = [["Under 18", 0],["18-24", 0],["25-34", 0],["35-44", 0],["45-54", 0],
#                   ["55-64", 0],["65 and older", 0]]
#
#     demo_hash["Age"].each do |birth_year,count|
#       age = Time.now.year - birth_year
#       if age < 18
#         age_buckets[0][1] += count
#       elsif age >= 18 && age < 24
#         age_buckets[1][1] += count
#       elsif age >= 25 && age < 34
#         age_buckets[2][1] += count
#       elsif age >= 35 && age < 44
#         age_buckets[3][1] += count
#       elsif age >= 45 && age < 54
#         age_buckets[4][1] += count
#       elsif age >= 55 && age < 64
#         age_buckets[5][1] += count
#       elsif age >= 65
#         age_buckets[6][1] += count
#       end
#     end
#
#     @age_chart_data = [["Age", "Count"]]
#     age_buckets.each{ |bucket| @age_chart_data << bucket }
#
#
  end
  

  
end
