class SetLanguageController < ApplicationController
  skip_before_action :authenticate_user!

  def english
    I18n.locale = :en
    set_session_and_redirect
  end

  def spanish
    I18n.locale = :es
    set_session_and_redirect
  end

  def french
    I18n.locale = :fr
    set_session_and_redirect
  end

  private

  def set_session_and_redirect
    session[:locale] = I18n.locale
    redirect_back(fallback_location: root_path)
  end
end
