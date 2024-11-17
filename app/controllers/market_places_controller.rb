class MarketPlacesController < ApplicationController
  before_action :set_nav_filter

  def index
    @categories = Category.to_nested_hash
    @products = Product.all.includes(:reviews)
    @products = @products.by_search(params[:search]) if params[:search].present?
    @products = @products.order(price: params[:price]) if params[:price].present?
    @products = @products.by_category(params[:category_id]) if params[:category_id].present?
    @products = @products.by_parent_category(params[:parent_category]) if params[:parent_category].present?
    @products = @products.order(created_at: params[:created_at]) if params[:created_at].present?
    @products = @products.by_review(params[:rating]) if params[:rating].present?
    @products = @products.where(id: params[:product_id]) if params[:product_id].present?
    @products = @products.popular_product if params[:popular].present?
    @products = @products.by_concern(params[:concern]) if params[:concern].present?
    @products = @products.by_ingredient(params[:ingredient]) if params[:ingredient].present?
    @pagy, @products = pagy(@products, items: 20)
    @query_params = request.query_parameters
  end
  
end