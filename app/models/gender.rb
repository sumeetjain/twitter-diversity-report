class Gender < ActiveRecord::Base
  validates :value, presence: true
  belongs_to :user
end
