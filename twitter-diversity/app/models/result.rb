class Result < ActiveRecord::Base
  attr_accessible :searched_handle, :education, :income, :age, :demo_hash
  
  validates :searched_handle, presence: true
  
  serialize :demo_hash, Hash
  
  def self.client
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["public"]  
      config.consumer_secret = ENV["secret"]
    end
  end
  
  def self.build_result_hash(client, searched_twitter_handle)
    matching_array = fetch_friend_matches(client, searched_twitter_handle)
    friend_answers = get_friend_answers(matching_array)
    demos = get_demo_types(friend_answers)
    demo_hash = generate_demo_hash(demos, friend_answers)
    return demo_hash
  end
  
  def self.fetch_friend_matches(client, searched_twitter_handle)
    
    user_array = []
    
    User.select("twitter_handle").each do |user_object| 
      user_array.push user_object.twitter_handle
    end

    friend_array = client.friends(searched_twitter_handle).to_a # TODO change to get ids.
    
    matching_array = []

    friend_array.each do |friend_object|
      if user_array.include?(friend_object.screen_name.downcase)
        matching_array << friend_object
      end
    end
    matching_array
  end
  
  
  def self.get_friend_answers(m)
    friend_answers = []
    
    m.each do |friend_obj|
      matched_user = User.find_by_twitter_handle(friend_obj.screen_name.downcase)
      friend_answers + matched_user.user_answers #SQL
    end
    friend_answers
  end
  
  def self.get_demo_types(friend_answers)
    demos = []
    friend_answers.each do |a|
      unless demos.include?(a.answer_type)
        demos.push a.answer_type
      end
    end
    demos
  end
  
  def self.generate_demo_hash(demos, friend_answers)
    demo_hash = {}
    demos.each do |d|
      sub_ans = subset_fa_by_demo(d,friend_answers)
      unique_ans = get_unique_answers(sub_ans)
      slice_hash = build_slice_hash(unique_ans, sub_ans)  #indirect SQL
      demo_hash[d] = slice_hash
    end
    demo_hash
  end
  
  def subset_fa_by_demo(d,friend_answers)
    demo_ans_array = []
    friend_answers.each do |a|
      if a.answer_type == d
        demo_ans_array.push a
      end
    end
    demo_ans_array
  end

  def get_unique_answers(sub_ans)
    unique_ans = []
    sub_ans.each do |a|
      unless unique_ans.include?(a.answer_id)
        unique_ans.push a.answer_id
      end
    end
    unique_ans
  end
  
  def build_slice_hash(unique_ans, sub_ans)
    slice_hash = {}
    unique_ans.each do |a|
      count = sub_ans.count{ |b| b.answer_id == a }
      answer = d.constantize.find(a).value #SQL
      slice_hash[answer] = count
    end
    slice_hash
  end
  
  def edu_chart(demo_hash)
    @edu_chart_data = [["Level Attained", "Count"]]
      demo_hash["Education"].each do |k,v|
        @edu_chart_data.push [k,v]
      end
  end
      
  def income_chart(demo_hash)
    income_buckets = [["Under 15000", 0],
                      ["15000 - 25000", 0],
                      ["25000 - 35000", 0],
                      ["35000 - 50000", 0],
                      ["50000 - 75000", 0],
                      ["75000 - 100000", 0],
                      ["100000 - 150000", 0],
                      ["Over 150000", 0]]
  
    demo_hash["Income"].each do |amount,count|
      if amount < 15000
        income_buckets[0][1] += count
      elsif amount >= 15000 && amount < 25000
        income_buckets[1][1] += count
      elsif amount >= 25000 && amount < 35000
        income_buckets[2][1] += count
      elsif amount >= 35000 && amount < 50000
        income_buckets[3][1] += count
      elsif amount >= 50000 && amount < 75000
        income_buckets[4][1] += count
      elsif amount >= 75000 && amount < 100000
        income_buckets[5][1] += count
      elsif amount >= 100000 && amount < 150000
        income_buckets[6][1] += count
      elsif amount >= 150000
        income_buckets[7][1] += count
      end
    end 
  
    @income_chart_data = [["Income", "Count"]]
    income_buckets.each{ |b| @income_chart_data.push b }
  end

  def age_chart(demo_hash)
    age_buckets = [["Under 18", 0],
                  ["18-24", 0],
                  ["25-34", 0],
                  ["35-44", 0],
                  ["45-54", 0],
                  ["55-64", 0],
                  ["65 and older", 0]]
              
    demo_hash["Age"].each do |birth_year,count|
    age = Time.now.year - birth_year
      if age < 18
        age_buckets[0][1] += count
      elsif age >= 18 && age < 24
        age_buckets[1][1] += count
      elsif age >= 25 && age < 34
        age_buckets[2][1] += count
      elsif age >= 35 && age < 44
        age_buckets[3][1] += count
      elsif age >= 45 && age < 54
        age_buckets[4][1] += count
      elsif age >= 55 && age < 64
        age_buckets[5][1] += count
      elsif age >= 65
        age_buckets[6][1] += count
      end
    end

    @age_chart_data = [["Age", "Count"]]
    age_buckets.each{ |bucket| @age_chart_data << bucket }
  end
  
  

end
