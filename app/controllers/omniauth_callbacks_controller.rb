class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    auth = request.env["omniauth.auth"]
    session[:access_token] = auth.credentials.token
    session[:expires_at] = auth.credentials.expires_at
    
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end
  
  alias_method :weibo, :all
  alias_method :qq_connect, :all
  alias_method :twitter, :all
  alias_method :github, :all
end
