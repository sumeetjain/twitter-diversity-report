require 'twitter'
require 'pry'

client = Twitter::REST::Client.new do |config|
  config.consumer_key    = ENV["public"]
  config.consumer_secret = ENV["secret"]
end

x = client.user("hilarysk")

binding.pry