class Orientation < ActiveRecord::Base
  validates :value, presence: true
  belongs_to :user
end
