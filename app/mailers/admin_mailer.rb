class AdminMailer < ApplicationMailer
  def new_user_signup(user)
    emails = AdminUser::ADMIN_EMAILS
    @user = user
    mail(to: emails, subject: "New User Signup: #{@user.email}")
  end
end
