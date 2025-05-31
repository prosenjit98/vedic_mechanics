class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable
  
  has_many :replies


  ADMIN_EMAILS = ["pmikuk@gmail.com", "preciagrotech@gmail.com", "nutrivediic@gmail.com"]

end
