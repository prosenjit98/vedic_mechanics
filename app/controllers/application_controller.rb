class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_nav_filter
  layout -> {
    if turbo_frame_request?
      "turbo_rails/frame"
    else
      "application"
    end
  }
  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :phone_number, :external_user_id])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :phone, :email, :password, :password_confirmation, :remember_me])
  end

  def set_nav_filter
    @categories = Category.to_nested_hash
    @concerns = Concern.all
    @ingredients = Ingredient.all
    @rating_hash = SiteRating.rate_percentages
    @banner_massage = AppConfiguration.find_by(key: "banner_massage")
  end
end
