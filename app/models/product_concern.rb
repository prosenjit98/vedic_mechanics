class ProductConcern < ApplicationRecord
  belongs_to :product
  belongs_to :concern
end
