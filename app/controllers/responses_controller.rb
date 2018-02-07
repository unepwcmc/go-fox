class ResponsesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :set_survey
  before_action :require_survey_published, only: [:new]
  before_action :set_response, only: [:show, :destroy]
  before_action :require_ownership, only: [:destroy]

  def new
    @questions  = Question.all
    @response   = Response.new
    @response.answers.build
  end

  def create
    @response             = Response.new(response_params)
    @response.survey      = @survey
    @response.ip_address  = request.remote_ip

    results = build_results

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
      return if @survey.published?
      redirect_to root_path, notice: "You cannot submit a response for an unpublished survey"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def response_params
      params.require(:response).permit(answers_attributes: [:raw, :answerable_type, :answerable_id])
    end

    def set_response
      @response = Response.find_by_uuid(params[:uuid])
    end

    def set_survey
      @survey = Survey.find_by_uuid(params[:survey_uuid])
    end


    def require_ownership
      unless (current_user == @response.survey.user) || (current_user.admin?)
        redirect_to survey_path(@response.survey), notice: "You are not the owner of that survey or an admin"
      end
    end

    def build_results
      answers_array   = []
      @response.answers.each do |answer|
        question = answer.question
        value    = calculate_value(answer.raw)
        question_data = {
          question_text:        question.text,
          question_x_weight:    question.x_weight,
          question_y_weight:    question.y_weight,
          question_z_weight:    question.z_weight,
          answer_inputted:      calculate_value(answer.raw),
          x_answer_calculated:  calculate_answer(value, question.x_weight),
          y_answer_calculated:  calculate_answer(value, question.y_weight),
          z_answer_calculated:  calculate_answer(value, question.z_weight)
        }
        answers_array << question_data
      end
    end

    def calculate_value(raw)
      case raw
      when "Strongly Disagree"
        -1
      when "Disagree"
        -0.5
      when "Agree"
        0.5
      when "Strongly Agree"
        1
      else
        0
      end
    end

    def calculate_answer(value, weight)
      value
    end
end
