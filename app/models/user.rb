class User < ActiveRecord::Base
  validates :twitter_id, presence: true, uniqueness: true
  has_many :ethnicities, dependent: :destroy
  accepts_nested_attributes_for :ethnicities

  def ethnicities_array
    ethnicities.map do |g|
      g.value
    end
  end

  def ethnicities_textarea
    ethnicities_array.join("\r\n")
  end

  def ethnicities_textarea=(text)
    self.ethnicities.delete_all
    input_array = text.split("\r\n")
    input_array.each do |e|
      self.ethnicities.new(value: e)
    end
  end
end
