class ResponsesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :require_survey_published, only: [:new]
  before_action :set_response, only: [:show, :destroy]

  def new
    @response = Response.new
  end

  def create
    @response = Response.new(response_params)
    @response.survey = Survey.find_by_uuid(params[:survey_uuid])
    @response.ip_address = request.remote_ip

    respond_to do |format|
      if @response.save
        format.html { redirect_to root_path, notice: 'Response was successfully created.' }
        format.json { render :show, status: :created, location: @response }
      else
        format.html { render :new }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def destroy
    @response.destroy
    redirect_to survey_path(@response.survey), notice: 'Response was succesfully deleted.'
  end

  private
    def require_survey_published
      survey = Survey.find_by_uuid(params[:survey_uuid])
      return if survey.published?
      redirect_to root_path, notice: "You cannot submit a response for an unpublished survey"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def response_params
      #params.require(:response).permit(:name, :published)
      return nil
    end

    def set_response
      @response = Response.find_by_uuid(params[:uuid])
    end
end
