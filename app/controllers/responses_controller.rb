class ResponsesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :require_survey_published, only: [:new]

  def new
    @response = Response.new
  end

  private
    def require_survey_published
      # return if @survey.published?
      # redirect_to root_path, notice: "You cannot view an unpublished survey"
    end
end
