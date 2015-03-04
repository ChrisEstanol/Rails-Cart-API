class User < ActiveRecord::Base

  before_create :generate_auth_token


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :products

  def cart_count
    $redis.hlen "cart#{id}"
  end

  private

  def generate_auth_token
    begin
      self.auth_token = SecureRandom.hex
    end while self.class.exists?(auth_token: auth_token)
  end

end
