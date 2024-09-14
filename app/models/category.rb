class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :child_categories, foreign_key: "parent_category_id", class_name: "Category"
  belongs_to :parent_category, foreign_key: "parent_category_id", class_name: "Category", optional: true

  validates :name, presence: true, uniqueness: true

  scope :search_by_name, -> (name) { where('name ILIKE ?', "%#{name}%") }

  def all_subcategories
    child_categories.includes(:child_categories).flat_map do |subcategory|
      [subcategory] + subcategory.all_subcategories
    end
  end

  def self.to_nested_hash(categories = Category.where(parent_category_id: nil))
    categories.map do |category|
      {
        id: category.id,
        name: category.name,
        children: to_nested_hash(category.child_categories),
        products: category.products.pluck([:id, :name]).to_h
      }
    end
  end
end
