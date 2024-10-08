class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :child_categories, foreign_key: "parent_category_id", class_name: "Category"
  belongs_to :parent_category, foreign_key: "parent_category_id", class_name: "Category", optional: true

  validates :name, presence: true, uniqueness: true

  def self.to_nested_hash(categories = Category.where(parent_category_id: nil))
    categories.map do |category|
      {
        id: category.id,
        name: category.name,
        children: to_nested_hash(category.child_categories)
      }
    end
  end
end
