class MarketPlacesController < ApplicationController

  def index
    @categories = Category.to_nested_hash
    @products = Product.vendor_products.includes(:reviews)
    @products = @products.by_search(params[:search]) if params[:search].present?
    @products = @products.order(price: params[:price]) if params[:price].present?
    @products = @products.by_category(params[:category_id]) if params[:category_id].present?
    @products = @products.order(created_at: params[:created_at]) if params[:created_at].present?
    @products = @products.by_review(params[:rating]) if params[:rating].present?
    @products = @products.popular_product if params[:popular].present?
    @pagy, @products = pagy(@products, items: 20)
    @query_params = request.query_parameters
  end
  
end