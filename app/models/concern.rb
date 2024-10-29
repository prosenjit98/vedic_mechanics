class Concern < ApplicationRecord
  has_one_attached :image
  has_many :product_concerns
  has_many :products, through: :product_concerns

  validates_presence_of :name, :description
end
