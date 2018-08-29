class Admin::DashboardController < ApplicationController
  before_action :require_admin

  def index
    @users = User.all
    @total_results = Survey.count
  end
end
