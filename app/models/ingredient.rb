class Ingredient < ApplicationRecord
  has_and_belongs_to_many :product, join_table: "product_ingredients", foreign_key: "product_id"
end
