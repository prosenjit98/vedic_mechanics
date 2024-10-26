class Concern < ApplicationRecord
  has_one_attached :image
  has_and_belongs_to_many :products, join_table: "product_concerns", foreign_key: "product_id"
end
