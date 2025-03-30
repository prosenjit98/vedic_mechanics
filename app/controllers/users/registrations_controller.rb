class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    # if verify_recaptcha
    #   super
    # else
    #   self.resource = resource_class.new sign_up_params
    #   self.resource.errors.add(:base, "reCAPTCHA verification failed.")
    #   render :new
    # end
  end
end