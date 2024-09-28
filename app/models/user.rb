class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable, :authentication_keys => [:login]
  has_many :orders
  has_one :cart
  has_many :reviews
  has_many :questions
  has_many :replies
  has_many :addresses
  has_many :payments



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
  

end
