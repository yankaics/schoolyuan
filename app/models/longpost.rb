class Longpost < ActiveRecord::Base
  validates :user_id, presence: true
  validates :content, presence: true
end
