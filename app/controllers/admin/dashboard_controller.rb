class Admin::DashboardController < ApplicationController
  before_action :require_admin, only: [:index, :export]

  def index
    @users = User.all
    @total_results = Response.count
  end

  def support
  end

  def about_go_fox
  end

  def legal
  end

  def export
    CsvUserExporterJob.perform_later(current_user.email)
    redirect_to admin_users_url, notice: "Your CSV is being generated, we will send an email to #{current_user.email} when it is ready to download"
  end
end
