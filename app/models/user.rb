class User < ActiveRecord::Base
  #attr_accessible :email, :name
  belongs_to :team
  has_many :records, dependent: :destroy
  
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 2 }


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    Record.where("user_id = ?", id)
  end

  def total
    rec = Record.where("user_id = ?", id)
    sum=0
    if rec.any?
      rec.each{ |f|
        sum = sum + f.steps
      }
      #     <%= "#{sum} steps so far" %>
    end
    return sum
  end


  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end