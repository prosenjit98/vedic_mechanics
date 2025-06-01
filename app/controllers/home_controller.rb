class HomeController < ApplicationController
  layout 'application'
  before_action :set_nav_filter
  def index
    initial_category = AppConfiguration.find_by(key: "initial_category")
    unless params[:home].present? && initial_category.present?
      redirect_to market_places_path(parent_category: initial_category.value)
    else
      @contact = Contact.new
      @categories = Category.to_nested_hash
      @new_products = Product.tagged_with('newest')
    end
  end

  def privacy_policy
  end

  def terms_conditions
  end

  def shipping_policy
  end

  def return_policy
  end

  def cancellation_policy
  end

  def contacts
    @contact = Contact.new
  end
end
