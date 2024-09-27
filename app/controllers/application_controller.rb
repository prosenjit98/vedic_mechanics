class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout -> {
    if turbo_frame_request?
      "turbo_rails/frame"
    else
      "application"
    end
  }
  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number, :external_user_id])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :phone, :email, :password, :password_confirmation, :remember_me])
  end
end
