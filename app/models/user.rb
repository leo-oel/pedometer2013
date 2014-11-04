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
    cnst = Constant.find(1)
    Record.where("user_id = ?", id).where("recdate >= ?", Time.parse(cnst.tally_from)).where("recdate < ?", Time.parse(cnst.tally_to)) 
  end

  def total
    rec = Record.where("user_id = ?", id)
    sum=0
    cnst = Constant.find(1)
    if rec.any?
      rec.each{ |f|
        if f.recdate >= Time.parse(cnst.tally_from) && f.recdate < Time.parse(cnst.tally_to) then
          sum = sum + f.steps
        end
      }
      #     <%= "#{sum} steps so far" %>
    end
    return sum
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end


  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!  UserMailer.password_reset(self).deliver
  end


  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end