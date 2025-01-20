class MarketPlacesController < ApplicationController
  before_action :set_nav_filter

  def index
    @categories = params[:parent_category].present? ? Category.to_nested_hash(Category.where(id: params[:parent_category])) : Category.to_nested_hash
    if params[:product_id].present?
      _product = Product.find(params[:product_id])
      _category = _product.top_parent_category
      @categories = Category.to_nested_hash([_category])
    end
    @products = Product.all.includes(:reviews)
    @products = @products.by_search(params[:search]) if params[:search].present?
    @products = @products.order(price: params[:price]) if params[:price].present?
    # @products = @products.by_category(params[:category_id]) if params[:category_id].present?
    if params[:parent_category].present? || params[:category_id].present?
      _category = Category.find(params[:category_id] || params[:parent_category])
      ids = [_category.all_subcategories.pluck(:id)] + [_category.id]
      @products = @products.by_category([ids].flatten)
    end
    @products = @products.order(created_at: params[:created_at]) if params[:created_at].present?
    @products = @products.by_review(params[:rating]) if params[:rating].present?
    @products = @products.where(id: params[:product_id]) if params[:product_id].present?
    @products = @products.popular_product if params[:popular].present?
    @products = @products.by_concern(params[:concern]) if params[:concern].present?
    @products = @products.by_ingredient(params[:ingredient]) if params[:ingredient].present?
    @products = @products.order(display_category: :asc)
    @pagy, @products = pagy(@products, items: 20)
    @query_params = request.query_parameters
  end
  
end