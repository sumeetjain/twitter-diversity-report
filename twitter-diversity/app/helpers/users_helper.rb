module UsersHelper
  def user_answer_field_label(answer_type)
    case answer_type
    when "Age"
      "Birth year"
    when "Income"
      "How much $$$$?????"
    end
  end
end
