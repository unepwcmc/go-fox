class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, except: [:support]

  layout 'public'

  def index
  end

  def about_project
  end

  def about_debate
  end

  def support
  end

  def legal
  end

  def about_go_fox
  end
end
