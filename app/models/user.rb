class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2], :authentication_keys => [:login]
  has_many :orders
  has_one :cart
  has_many :reviews
  has_many :questions
  has_many :replies
  has_many :addresses
  has_many :payments


  before_validation :set_external_user_id
  validates :phone_number, presence: true, uniqueness: true, length: { is: 10 }

  attr_writer :login
  def login
    @login || self.email || self.phone_number
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(
      ["lower(email) = :value OR phone_number = :value", { value: login.downcase }]
    ).first
  end


  def full_name
    if first_name.present? && last_name.present?
      self.first_name + " " + self.last_name
    else
      "User"
    end
  end

  def default_address
    addresses.default.first
  end

  def self.from_google(u)
    create_with(uid: u[:uid], provider: 'google', first_name: u[:first_name], last_name: u[:last_name], password: Devise.friendly_token[0, 20], phone_number: set_code).find_or_create_by!(email: u[:email])
  end

  private 

  def self.set_code
    generate_unique_code
  end

  def self.generate_unique_code
    loop do
      code = Array.new(10) { rand(0..9) }.join
      break code unless User.exists?(phone_number: code)
    end
  end

  def set_external_user_id
    self.external_user_id = self.external_user_id || SecureRandom.uuid
  end
  

end
