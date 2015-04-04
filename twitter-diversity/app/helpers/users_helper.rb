module UsersHelper
  def user_answer_field_label(answer_type)
    case answer_type
    when "Age"
      "Year you were born (YYYY): "
    when "Income"
      "Annual income (USD):"
    when "Education"
      "Highest level of education attained"
    when "Ethnicity"
      "Ethnicity"
    when "Gender"
      "Gender"
    when "Orientation"
      "Orientation"
    end
  end
end
