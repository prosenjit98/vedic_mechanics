class Ingredient < ApplicationRecord
  has_many :product_ingredients
  has_many :products, through: :product_ingredients
  has_many_attached :images

  has_rich_text :description
end
