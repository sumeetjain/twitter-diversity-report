class Searchresult < ActiveRecord::Base

  def self.client
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["PUBLIC"]
      config.consumer_secret = ENV["SECRET"]
    end
  end

















end
