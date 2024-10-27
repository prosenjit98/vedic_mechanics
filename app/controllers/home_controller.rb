class HomeController < ApplicationController
  layout 'application'
  before_action :set_nav_filter
  def index
    @contact = Contact.new
    @categories = Category.to_nested_hash
    @new_products = Product.tagged_with('newest')
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
