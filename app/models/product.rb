class Product < ApplicationRecord
  acts_as_paranoid
  acts_as_taggable_on :tags
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  belongs_to :vendor, optional: true
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :cart_items
  has_many :carts, through: :cart_items
  has_many :reviews
  has_many :questions
  has_many :product_variants
  has_many :variants, through: :product_variants
  has_many :product_concerns
  has_many :concerns, through: :product_concerns
  has_many :product_ingredients
  has_many :ingredients, through: :product_ingredients


  has_many_attached :product_images

  accepts_nested_attributes_for :product_variants
  has_rich_text :specification

  validates :name, presence: true
  validates :original_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :approx_delivery_cost, presence: true,  numericality: { greater_than_or_equal_to: 0 }
  validates :discount, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validate :at_least_has_one_category


  after_save :update_price 

  scope :by_search,     lambda { |search| where('name ILIKE ?', "%#{search.downcase}%")}
  scope :by_category,   lambda { |category_id| joins(:categories).where('categories.id': category_id) }
  scope :by_parent_category, lambda { |category_id| joins(:categories).where('categories.parent_category_id = ?', category_id) }
  scope :by_review,     lambda { |review| left_joins(:reviews).group('products.id').having('AVG(reviews.rating) > ?', review) }
  scope :own_products,  lambda { where(vendor_id: nil) }
  scope :vendor_products, lambda { where.not(vendor_id: nil) }
  scope :by_concern,    lambda { |concern| joins(:concerns).where('concerns.id = ?', concern) }
  scope :by_ingredient, lambda { |ingredient| joins(:ingredients).where('ingredients.id = ?', ingredient) }

  PRODUCT_VARIANTS = ['weight', 'size', 'volume', 'color']

  def self.popular_product
    left_joins(:reviews).group('products.id').order('COUNT(reviews.id) DESC')
  end

  def at_least_has_one_category
    errors.add(:categories, "must have at least one category") if categories.empty?
  end


  def update_price
    price = (original_price * (1 - discount / 100))
    update_columns(price: price)
  end

  def product_ratings
    reviews&.average(:rating)&.round(1) || 0
  end

  def review_count 
    reviews.count
  end

  def avarage_rating
    reviews&.average(:rating)&.round(1) || 0
  end

  ['image', 'video'].each do |key|
    define_method "is_#{key}?" do |arg|
      arg.content_type.start_with?("#{key}/")
    end
  end

  def top_parent_category
    top_parent = self.categories.first
    parent = self.categories.first.parent_category
    while parent.present?
      top_parent = parent
      parent = parent.parent_category
    end
    top_parent
  end

end
