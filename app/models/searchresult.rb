class Searchresult < ActiveRecord::Base
  def self.client
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["public"]
      config.consumer_secret = ENV["secret"]
    end
  end

  def self.userinfo
    userinfo = HTTParty.get("https://api.twitter.com/1.1/users/show.json?screen_name=noto-alex-j")
  end

















end
