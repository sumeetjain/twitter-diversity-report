require 'twitter'
require 'pry'

client = Twitter::REST::Client.new do |config|
  config.consumer_key    = "PWzXFXFVzGwrXwj6J87iApxZ2"
  config.consumer_secret = "2VgCmjVJtqZ7Lh9jfL5vMUuY5LEEzoFNBJL4fvkVDO913RAple"
end

x = client.user("hilarysk")

binding.pry