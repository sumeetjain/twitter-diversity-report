class User < ActiveRecord::Base
  validates :twitter_id, presence: true, uniqueness: true
  has_many :ethnicities, dependent: :destroy

  def ethnicities_textarea
    set_textarea("ethnicities")
  end

  def ethnicities_textarea=(text)
    get_textarea("ethnicities", text)
  end

  private
    def field_array(field)
      send(field).map do |entry|
        entry.value
      end
    end

    def set_textarea(field)
      field_array(field).join("\r\n")
    end

    def get_textarea(field, text)
      send(field).delete_all
      input_array = text.split("\r\n")
      input_array.each do |x|
        send(field).new(value: x)
      end
    end
end
