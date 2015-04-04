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
    
    twitter_ids = client.friend_ids(searched_twitter_handle).attrs[:ids]

    demos = UserAnswer.joins(:user).where(users:{twitterid: twitter_ids}).select("distinct answer_type").map{ |a| a.answer_type }

    result_hash = {}

    demos.each do |demo|
      demo_hash = {}
      d = demo.downcase.pluralize

      answer_groups = UserAnswer.joins("INNER JOIN #{d} ON user_answers.answer_id = #{d}.id").joins("INNER JOIN users ON user_answers.user_id = users.id").where({answer_type: demo}).where(users:{twitterid:twitter_ids}).select("#{d}.value AS answer_value, COUNT(user_answers.id) AS answer_count").group("#{d}.value")
      

      answer_groups.each do |g|
        unless !/\A\d+\z/.match(g.answer_value)
          g.answer_value = g.answer_value.to_i
        end
        demo_hash[g.answer_value] = g.answer_count.to_i
      end
      result_hash[demo] = demo_hash
    end
    result_hash
  end
  
 
  
  def edu_chart
    @edu_chart_data = [["Level Attained", "Count"]]
    self.demo_hash["Education"].each do |k,v|
      @edu_chart_data.push [k,v]
    end
  end
      
  def income_chart
    income_buckets = [["Under 15000", 0],
                      ["15000 - 25000", 0],
                      ["25000 - 35000", 0],
                      ["35000 - 50000", 0],
                      ["50000 - 75000", 0],
                      ["75000 - 100000", 0],
                      ["100000 - 150000", 0],
                      ["Over 150000", 0]]
  
    self.demo_hash["Income"].each do |amount,count|
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

  def age_chart
    age_buckets = [["Under 18", 0],
                  ["18-24", 0],
                  ["25-34", 0],
                  ["35-44", 0],
                  ["45-54", 0],
                  ["55-64", 0],
                  ["65 and older", 0]]
              
    self.demo_hash["Age"].each do |birth_year,count|
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
  
  
  def orientation_chart
    @orientation_chart_data = [["Orientation", "Count"]]
    self.demo_hash["Orientation"].each do |k,v|
      @orientation_chart_data.push [k,v]
    end
  end
  
  def gender_chart
    @gender_chart_data = [["Gender", "Count"]]
    self.demo_hash["Gender"].each do |k,v|
      @gender_chart_data.push [k,v]
    end
  end
  
  def ethnicity_chart
    @ethnicity_chart_data = [["Ethnicity", "Count"]]
    self.demo_hash["Ethnicity"].each do |k,v|
      @ethnicity_chart_data.push [k,v]
    end
  end
  
end
