class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :skip_password
  validates :password, length: { in: 6..20 }, unless: :skip_password
  validates :password_confirmation, length: { in: 6..20 }, unless: :skip_password
  before_save :ensure_authentication_token
  has_one :profile
  has_many :comments
  has_many :user_product_favorites
  has_many :user_carts


  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
