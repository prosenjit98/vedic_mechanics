class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = User.from_google(from_google_params)

    if user.present?
      sign_out_all_scopes
      flash[:notice] = t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in user, event: :authentication

      redirect_url = request.env['omniauth.origin']
      if redirect_url.present? && URI.parse(redirect_url).host == request.host
        redirect_to redirect_url
      else
        redirect_to root_path
      end
      # sign_in_and_redirect user, event: :authentication, allow_other_host: true
    else
      flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
      redirect_to new_user_session_path
    end
  end

  def from_google_params

    @from_google_params ||= {
      uid: auth.uid,
      email: auth.info.email,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name
    }
  end

  def auth
    @auth ||= request.env['omniauth.auth']
  end
end


