class Ingredient < ApplicationRecord
  has_many :product_ingredients
  has_many :products, through: :product_ingredients
  has_many_attached :images

  has_rich_text :description

  def self.search(search)
    if search
      where("ingredients.name ILIKE ?", "%#{search}%")
      # left_joins(:products).where("ingredients.name ILIKE ? or products.name ILIKE ? or products.product_code ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%").distinct
    else
      scoped
    end
  end
end
