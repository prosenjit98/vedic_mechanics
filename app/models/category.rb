class Category < ApplicationRecord
  acts_as_list top_of_list: 1, scope: [:parent_category_id]
  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories
  has_many :child_categories, foreign_key: "parent_category_id", class_name: "Category"
  belongs_to :parent_category, foreign_key: "parent_category_id", class_name: "Category", optional: true

  before_validation :initialize_position

  validates :name, presence: true, uniqueness: true
  validates :position, uniqueness: { scope: [:parent_category_id], message: "must be unique within the same parent" }

  scope :search_by_name, -> (name) { where('name ILIKE ?', "%#{name}%") }
  scope :parent_categories, -> { where(parent_category_id: nil) }

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
        products: category.products.own_products.pluck([:id, :name]).to_h
      }
    end
  end

  def self.to_vendor_nested_hash(categories = Category.where(parent_category_id: nil))
    categories.map do |category|
      {
        id: category.id,
        name: category.name,
        children: to_nested_hash(category.child_categories),
        products: category.products.vendor_products.pluck([:id, :name]).to_h
      }
    end
  end

  private

  def initialize_position
    last_position = Category.where(parent_category_id: self.parent_category_id).order(:position).last&.position
    self.position ||= last_position.to_i + 1
  end
end
