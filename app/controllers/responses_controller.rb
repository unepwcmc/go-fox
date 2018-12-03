class ResponsesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :results]
  before_action :set_survey
  before_action :require_survey_published, only: [:new]
  before_action :set_response, only: [:show, :results, :destroy]
  before_action :require_ownership, only: [:show, :destroy]
  before_action :require_survey_unlocked, only: [:new]
  layout :resolve_layout

  def index
    @responses = @survey.responses

    @results_chart_data = [
      {
        current_user: false,
        dataset: [-2.4, -2.9, 2.6]
      }, 
      {
        current_user: false,
        dataset: [-3, 0 , 3]
      }
    ].to_json
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
    answer_params = validate_survey_responses(survey_response_params)
    redirect_to(new_survey_response_path(@survey), alert: 'Invalid survey submission.') && return if answer_params[:status == :failure]

    @response            = Response.new(answer_params[:response])
    @response.survey     = @survey
    @response.ip_address = request.remote_ip
    @response.language   = params[:locale]

    respond_to do |format|
      if @response.save
        format.html { redirect_to results_survey_response_path(@survey, @response), notice: 'Response was successfully created.' }
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
    @results_chart_data = [
      {
        current_user: true,
        dataset: [@response.f1_score, @response.f2_score, @response.f3_score]
      }, 
      {
        current_user: false,
        dataset: [-3, 0 , 3]
      }
    ].to_json
  end

  def destroy
    @response.destroy
    redirect_to survey_path(@response.survey), notice: 'Response was succesfully deleted.'
  end

  private

    def resolve_layout
      case action_name
      when "results"
        "public"
      else
        "application"
      end
    end

    def require_survey_published
      return if @survey.published?
      redirect_to root_path, notice: "You cannot submit a response for an unpublished survey"
    end

    def require_survey_unlocked
      return unless @survey.locked?
      redirect_to root_path, notice: "This survey has been locked by an administrator and cannot be answered at this time. Please try again later."
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_response_params
      # Raw can be passed as either a string or an array in case of multiple answer questions like checkboxes
      params.require(:response).permit(answers_attributes: [{raw: []}, :raw, :answerable_type, :answerable_id])
    end

    def validate_survey_responses(params)
      status = :failure
      answers = params["answers_attributes"].values

      required_questions = Question.order("RANDOM()").pluck(:id) rescue []
      customised_questions = @survey.customised_questions.pluck(:id) rescue []
      excluded_demographic_ids = customised_questions.pluck(:demographic_question_id) rescue []
      demographic_questions = DemographicQuestion.where(validation: {required: true}.to_json) rescue []
      required_demographic_questions = demographic_questions.reject { |id| excluded_demographic_ids.include?(id) } rescue []

      answers.each do |answer|
        required_questions.delete(answer["answerable_id"].to_i) if (answer["answerable_type"] == "Question")
        required_demographic_questions.delete(answer["answerable_id"].to_i) if (answer["answerable_type"] == "DemographicQuestion")
        customised_questions.delete(answer["answerable_id"].to_i) if (answer["answerable_type"] == "CustomisedQuestion")
      end

      status = :success if (required_questions.empty? && customised_questions.empty? && required_demographic_questions.empty?)
      {
        status: status,
        response: params
      }
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
