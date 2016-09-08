class Searchresult < ActiveRecord::Base
  def self.client
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["PUBLIC"]
      config.consumer_secret = ENV["SECRET"]
    end
  end

  def self.testedfriends(client, searched_twitter_handle)
    twitter_ids = client.friend_ids(searched_twitter_handle).attrs[:ids]
    friendresults = User.where(twitter_id: twitter_ids)
    return friendresults
  end
















end
