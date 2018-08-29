class Admin::DashboardController < ApplicationController
  def index
    @users = User.all
    @total_results = Survey.count
  end
end
