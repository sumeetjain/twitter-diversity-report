User.select("twitter_handle").each_with_object([]) do |object, user_array| 
  user_array.push object.twitter_handle
end

follower_array = client.friends("cza_dev").to_a

follower_array.each_with_object([]) do |object, matching_array|
  if user_array.include?(object.screen_name.downcase)
    matching_array.push object
  end
end