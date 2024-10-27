class Concern < ApplicationRecord
  has_one_attached :image
  has_many :product_concerns
  has_many :products, through: :product_concerns
end
