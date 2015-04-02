class Result < ActiveRecord::Base
  attr_accessible :searched_handle, :education, :income, :age
  
  validates :searched_handle, presence: true
  
  serialize :demo_hash, Hash
  
<<<<<<< HEAD
  def get_friend_answers(m)
    friend_answers = []
    m.each do |friend_obj|
      friend_answers += friend_obj.user_answers #SQL
    end
    friend_answers
  end
  
  def get_demo_types(friend_answers)
    demos = []
    friend_answers.each do |a|
      unless demos.include?(a.answer_type)
        demos.push a.answer_type
      end
    end
    demos
  end
  
  def generate_demo_hash(demos, friend_answers)
    demos.each do |d|
      sub_ans = subset_fa_by_demo(d,friend_answers)
      unique_ans = get_unique_answers(sub_ans)
      slice_hash = build_slice_hash(unique_ans, sub_ans)  #indirect SQL
      demo_hash[d] = slice_hash
    end
  end
  
  def subset_fa_by_demo(d,friend_answers)
    demo_ans_array = []
    friend_answers.each do |a|
      if a.answer_type == d
        demo_ans_array.push a
      end
    end
    demo_ans_array
  end

  def get_unique_answers(sub_ans)
    unique_ans = []
    sub_ans.each do |a|
      unless unique_ans.include?(a.answer_id)
        unique_ans.push a.answer_id
      end
    end
    unique_ans
  end
  
  def build_slice_hash(unique_ans, sub_ans)
    slice_hash = {}
    unique_ans.each do |a|
      count = sub_ans.count{ |b| b.answer_id == a }
      answer = d.constantize.find(a).value #SQL
      slice_hash[answer] = count
    end
    slice_hash
  end
=======
>>>>>>> 3a65edfb735954cf4fd057522f3dac41276ed335
end
