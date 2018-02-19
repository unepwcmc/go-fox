class ResponsesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :results]
  before_action :set_survey
  before_action :require_survey_published, only: [:new]
  before_action :set_response, only: [:show, :results, :destroy]
  before_action :require_ownership, only: [:show, :destroy]

  def new
    @response = Response.new

    @questions = Question.order("RANDOM()") + DemographicQuestion.last(1)

    @questions.each do |question|
      @response.answers.build do |answer|
        answer.answerable = question
      end
    end
  end

  def create
    @response            = Response.new(response_params)
    @response.survey     = @survey
    @response.ip_address = request.remote_ip
    @response.language   = params[:locale]

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

  def results
  end

  def destroy
    @response.destroy
    redirect_to survey_path(@response.survey), notice: 'Response was succesfully deleted.'
  end

  private
    def require_survey_published
      return if @survey.published?
      redirect_to root_path, notice: "You cannot submit a response for an unpublished survey"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def response_params
      # Raw can be passed as either a string or an array in case of multiple answer questions like checkboxes
      params.require(:response).permit(answers_attributes: [{raw: []}, :raw, :answerable_type, :answerable_id])
    end

    def set_response
      @response = Response.find_by_uuid(params[:uuid])
    end

    def set_survey
      @survey = Survey.find_by_uuid(params[:survey_uuid])
    end

    def require_ownership
      unless (current_user == @response.survey.user) || (current_user.admin?)
        redirect_to root_path, notice: "You are not the owner of that survey or an admin"
      end
    end
end
