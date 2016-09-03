class User < ActiveRecord::Base
  validates :twitter_id, presence: true, uniqueness: true
end