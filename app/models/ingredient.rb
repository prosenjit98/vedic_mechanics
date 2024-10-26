class Ingredient < ApplicationRecord
  has_and_belongs_to_many :products, join_table: "product_ingredients", foreign_key: "product_id"
end
