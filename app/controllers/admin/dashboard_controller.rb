class Admin::DashboardController < ApplicationController
  before_action :require_admin, only: [:index, :export]
  before_action :set_default_locale, only: :index

  def index
    @users = User.all
    @total_results = Response.count
  end

  def support
  end

  def resources
  end

  def legal
  end

  def export
    CsvUserExporterJob.perform_later(current_user.email)
    redirect_to admin_users_url, notice: "Your CSV is being generated, we will send an email to #{current_user.email} when it is ready to download"
  end

  private

  def set_default_locale
    session[:locale] = I18n.default_locale
  end
end
