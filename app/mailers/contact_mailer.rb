class ContactMailer < ApplicationMailer
  def contact_email(contact)
    @contact = contact
    emails = AdminUser::ADMIN_EMAILS
    mail(to: emails, subject: "New Contact Us Message - Reference ID: #{contact.msg_rf_id}") if emails.present?
  end

  def site_comment site_rating
    emails = AdminUser::ADMIN_EMAILS
    emails = 'prosenjit.chongder@geogo.in'
    @site_ratings = site_rating
    @user = User.find_by(external_user_id: site_rating.external_user_id)
    mail(to: emails, subject: "New Rating from user - Reference ID: #{site_rating.id}") if @user.present?
  end
end
