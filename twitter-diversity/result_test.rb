# User.select("twitter_handle").each do |user_object|
#   user_array.push user_object.twitter_handle
# end



User.select("twitter_handle").each_with_object([]) do |user_object, user_array| 
  user_array.push user_object.twitter_handle
end

friend_array = client.friends(searched_twitter_handle).to_a

friend_array.each_with_object([]) do |friend_object, matching_array|
  if user_array.include?(friend_object.screen_name.downcase)
    matching_array.push friend_object
  end
end

friend_answers = []
friend_answers2 = []
matching_array.each do |friend_object|
  friend_answers = friend_answer + friend_object.user_answers
  friend_answers2 += friend_object.user_answers
end
demographics = []
friend_answers.each do |a|
  unless demographics.include?(a.answer_type)
    demographics.push a.answer_type
  end
end
demo_hash = {}
demographics.each do |d|
  demo_answers = []
  friend_answers.each do |a|
    if a.answer_type == d
      demo_answers.push a
    end
  end
  unique_ans = []
  demo_answers.each do |a|
    unless unique_ans.include?(a.answer_id)
      unique_ans.push a.answer_id
    end
  end
  slice_hash = {}
  unique_ans.each do |a|
    count = demo_answers.count{|b| b.answer_id == a}
    answer = d.constantize.find(a)
    slice_hash[answer] = count
  end
  demo_hash[d] = slice_hash
end
binding.pry