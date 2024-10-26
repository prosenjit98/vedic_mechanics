class Concern < ApplicationRecord
  has_and_belongs_to_many :product, join_table: "product_concerns", foreign_key: "product_id"
end
