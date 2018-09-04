class ResponsesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :results]
  before_action :set_survey
  before_action :require_survey_published, only: [:new]
  before_action :set_response, only: [:show, :results, :destroy]
  before_action :require_ownership, only: [:show, :destroy]
  before_action :require_survey_unlocked, only: [:new]

  def index
    @responses = @survey.responses
  end

  def new
    @response = Response.new
    @questions = @survey.questions

    @questions.each do |question|
      @response.answers.build do |answer|
        answer.answerable = question
      end
    end

    render layout: 'public'
  end

  def create
    answer_params = validate_responses(response_params)

    if answer_params.present?
      @response            = Response.new(answer_params)
      @response.survey     = @survey
      @response.ip_address = request.remote_ip
      @response.language   = params[:locale]

      respond_to do |format|
        if @response.save && answer_params.present?
          format.html { redirect_to root_path, notice: 'Response was successfully created.' }
          format.json { render :show, status: :created, location: @response }
        else
          format.html { render :new }
          format.json { render json: @response.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_survey_response_path(@survey), error: 'Invalid survey submission.'
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

    def require_survey_unlocked
      return unless @survey.locked?
      redirect_to root_path, notice: "This survey has been locked by an administrator and cannot be answered at this time. Please try again later."
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def response_params
      # Raw can be passed as either a string or an array in case of multiple answer questions like checkboxes
      params.require(:response).permit(answers_attributes: [{raw: []}, :raw, :answerable_type, :answerable_id])
    end

    def validate_responses(params)
      answers = provided_answer_ids = params["answers_attributes"].values

      required_questions = Question.pluck(:id)
      required_demographic_questions = DemographicQuestion.where(validation: {required: true}.to_json).pluck(:id)

      answers.each do |answer|
        required_questions.delete(answer["answerable_id"].to_i) if (answer["answerable_type"] == "Question")
        required_demographic_questions.delete(answer["answerable_id"].to_i) if (answer["answerable_type"] == "DemographicQuestion")
      end

      return params if (required_questions.empty? && required_demographic_questions.empty?)
      nil
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
