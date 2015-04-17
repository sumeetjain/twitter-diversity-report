class Result < ActiveRecord::Base
  attr_accessible :searched_handle, :education, :income, :age, :demo_hash, :gender, :orientation, :ethnicity
  
  validates :searched_handle, presence: true
  
  serialize :demo_hash, Hash
  

  def self.client
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["public"]  
      config.consumer_secret = ENV["secret"]
    end
  end
  

  def self.build_result_hash(client, searched_twitter_handle)
    
    twitter_ids = client.friend_ids(searched_twitter_handle).attrs[:ids]

    demos = UserAnswer.joins(:user).where(users:{twitterid: twitter_ids}).select("distinct answer_type").map{ |a| a.answer_type }

    result_hash = {
      "total_friend_count" => twitter_ids.length,
      "friends_who_answered" => UserAnswer.joins(:user).where(users:{twitterid: twitter_ids}).select("distinct user_id").length
    }

    demos.each do |demo|
      demo_hash = {
        "values" => {},
        "ans_p_friend" => {}
      }
      d = demo.downcase.pluralize

      answer_groups = UserAnswer.joins("INNER JOIN #{d} ON user_answers.answer_id = #{d}.id").joins("INNER JOIN users ON user_answers.user_id = users.id").where({answer_type: demo}).where(users:{twitterid:twitter_ids}).select("#{d}.value AS answer_value, COUNT(user_answers.id) AS answer_count").group("#{d}.value")

      num_user_ans = UserAnswer.joins("INNER JOIN #{d} ON user_answers.answer_id = #{d}.id").joins("INNER JOIN users ON user_answers.user_id = users.id").where({answer_type: demo}).where(users:{twitterid:twitter_ids}).select("user_id AS ans_user, COUNT(answer_id) AS user_answer_count").group("user_id")

      answer_groups.each do |g|
        unless !/\A\d+\z/.match(g.answer_value)
          g.answer_value = g.answer_value.to_i
        end
        if demo == "Gender" || demo == "Ethnicity" || demo == "Orientation" || demo == "Education"
          if demo_hash["values"].has_key?(g.answer_value.upcase)
            demo_hash["values"][g.answer_value.upcase] += g.answer_count.to_i
          else 
            demo_hash["values"][g.answer_value.upcase] = g.answer_count.to_i
          end
        else
          demo_hash["values"][g.answer_value] = g.answer_count.to_i
        end
      end
      
      num_user_ans.each do |u|
        demo_hash["ans_p_friend"][u.ans_user.to_i] = u.user_answer_count.to_i
      end
      
      result_hash[demo] = demo_hash
    end
    
    result_hash
  end
  
  def response_data(ans_p_friend)
    resp_data = {}
    ans_p_friend.each do |k,v|
      if resp_data.has_key? v.to_i
        resp_data[v.to_i] += 1
      else
        resp_data[v.to_i] = 1
      end
    end
    resp_data
  end
  
  def edu_chart
    @edu_chart_data = [["Level Attained", "Count"]]
    self.demo_hash["Education"]["values"].each do |k,v|
      @edu_chart_data.push [k,v]
    end
  end
  
  def edu_response_data
    @edu_response_data = [["Number of Responses", "Count"]]
    resp_data = response_data(self.demo_hash["Education"]["ans_p_friend"])
    resp_data.each do |r,c|
      @edu_response_data << [r,c]
    end
    @edu_response_data
  end
    
    
      
  def income_chart
    income_buckets = [["Under 15,000", 0],
                      ["15,000 - 25,000", 0],
                      ["25,000 - 35,000", 0],
                      ["35,000 - 50,000", 0],
                      ["50,000 - 75,000", 0],
                      ["75,000 - 100,000", 0],
                      ["100,000 - 150,000", 0],
                      ["Over 150,000", 0]]
  
    self.demo_hash["Income"]["values"].each do |amount,count|
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
  
  
  def income_response_data
    @income_response_data = [["Number of Responses", "Count"]]
    resp_data = response_data(self.demo_hash["Income"]["ans_p_friend"])
    resp_data.each do |r,c|
      @income_response_data << [r,c]
    end
    @income_response_data
  end
  

  def age_chart
    age_buckets = [["Under 18", 0],
                  ["18-24", 0],
                  ["25-34", 0],
                  ["35-44", 0],
                  ["45-54", 0],
                  ["55-64", 0],
                  ["65 and older", 0]]
              
    self.demo_hash["Age"]["values"].each do |birth_year,count|
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
  
  
  def age_response_data
    @age_response_data = [["Number of Responses", "Count"]]
    resp_data = response_data(self.demo_hash["Age"]["ans_p_friend"])
    resp_data.each do |r,c|
      @age_response_data << [r,c]
    end
    @age_response_data
  end
  
 
  def orientation_chart
    @orientation_chart_data = [["Orientation", "Count"]]
    self.demo_hash["Orientation"]["values"].each do |k,v|
      @orientation_chart_data.push [k,v]
    end
  end


  def orientation_response_data
    @orientation_response_data = [["Number of Responses", "Count"]]
    resp_data = response_data(self.demo_hash["Orientation"]["ans_p_friend"])
    resp_data.each do |r,c|
      @orientation_response_data << [r,c]
    end
    @orientation_response_data
  end


  def gender_chart
    @gender_chart_data = [["Gender", "Count"]]
    self.demo_hash["Gender"]["values"].each do |k,v|
      @gender_chart_data.push [k,v]
    end
  end


  def gender_response_data
    @gender_response_data = [["Number of Responses", "Count"]]
    resp_data = response_data(self.demo_hash["Gender"]["ans_p_friend"])
    resp_data.each do |r,c|
      @gender_response_data << [r,c]
    end
    @gender_response_data
  end


  def ethnicity_chart
    @ethnicity_chart_data = [["Ethnicity", "Count"]]
    self.demo_hash["Ethnicity"]["values"].each do |k,v|
      @ethnicity_chart_data.push [k,v]
    end
  end
  
  
  def ethnicity_response_data
    @ethnicity_response_data = [["Number of Responses", "Count"]]
    resp_data = response_data(self.demo_hash["Ethnicity"]["ans_p_friend"])
    resp_data.each do |r,c|
      @ethnicity_response_data << [r,c]
    end
    @ethnicity_response_data
  end
  
end
