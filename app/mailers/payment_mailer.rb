class PaymentMailer < ApplicationMailer
  def payment_confirmation(payment)
    @payment = payment
    @user = @payment.user
    emails = AdminUser::ADMIN_EMAILS
    mail(to: emails, subject: "New payment received - from client: #{@payment.user.full_name}") if emails.present?
  end
end