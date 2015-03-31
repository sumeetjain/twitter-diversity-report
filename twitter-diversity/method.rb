User.select("twitter_handle").each_with_object([]) do |user_object, user_array| 
  user_array.push user_object.twitter_handle
end

friend_array = client.friends("cza_dev").to_a

friend_array.each_with_object([]) do |friend_object, matching_array|
  if user_array.include?(friend_object.screen_name.downcase)
    matching_array.push friend_object
  end
end