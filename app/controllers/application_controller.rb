class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
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

    devise_parameter_sanitizer.permit(:sign_up, keys: keys +
                                     [:use_type, :org_type, :org_type_other,
                                      :country, :wider_network, :wider_network_details])
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
  end

  def require_admin
    return if current_user.admin?
    redirect_to root_path, notice: "Only admins can access this"
  end

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end
end
