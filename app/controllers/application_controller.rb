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

  def after_sign_in_path_for(resource)
    # request.referrer
    cookies_path = cookies[:return_to_url]
    cookies[:return_to_url] = nil
    cookies_path || request.referrer || root_path
  end

  private
  def storable_location?
    request.get? &&
      is_navigational_format? &&
      !devise_controller? &&
      !request.xhr? &&
      !request.fullpath.start_with?("/users/auth")
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  # def after_sign_in_path_for(resource_or_scope)
  #   stored_location_for(resource_or_scope) || super
  # end
end
