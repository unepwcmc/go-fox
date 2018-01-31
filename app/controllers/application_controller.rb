class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    keys = [
      :organisation_name,
      :email,
      :username,
      :password,
      :password_confirmation,
      :admin
    ]

    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end
