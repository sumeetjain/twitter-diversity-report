require 'twitter'
require 'pry'

client = Twitter::REST::Client.new do |config|
  config.consumer_key    = ENV["public"]
  config.consumer_secret = ENV["secret"]
  # right now these are defined with Sumeet's keys for another application
end

x = client.user("hilarysk")

binding.pry