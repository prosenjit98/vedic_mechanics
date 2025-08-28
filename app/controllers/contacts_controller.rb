class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    is_verified = verify_recaptcha(model: @contact)
    if is_verified && @contact.save
      respond_to do |format|
        format.turbo_stream 
        format.html { redirect_to contacts_home_index_path, notice: "Your message has been sent." }
      end
    else
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to contacts_home_index_path, notice: "There was an error sending your message." }
      end
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message, :msg_rf_id, :phone_number, :country_code)
  end
end
