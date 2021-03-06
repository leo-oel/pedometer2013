class Record < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :steps, presence: true
  validates :recdate, presence: true
  validates :user_id, presence: true
end
