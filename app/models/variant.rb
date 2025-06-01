class Variant < ApplicationRecord
  has_many :product_variants
  has_many :products, through: :product_variants
end











