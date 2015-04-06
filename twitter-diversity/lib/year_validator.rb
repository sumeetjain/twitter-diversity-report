class YearValidator < ActiveModel::Validator
  def validate(record)
    if record.value < 1900 || record.value > Time.current.year
      record.errors.add(:age, "cannot be less than 1900 and over #{Time.current.year}.  Try again!")
    end
  end
end