class Admin::DashboardController < ApplicationController
  before_action :require_admin

  def index
    @users = User.all
    @total_results = Survey.count
  end

  def support
  end

  def about_go_fox
  end

  def legal
  end
end
