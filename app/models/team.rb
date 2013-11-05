class Team < ActiveRecord::Base
  has_many :users

  validates :name, presence: true, length: { maximum: 50 }

  def member
    User.where("team_id = ?", id)
  end

end
