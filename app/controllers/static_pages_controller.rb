class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  layout 'public'

  def index
  end

  def about_project
  end

  def about_debate
  end

  def about_go_fox
  end

  def legal
  end
end
