class SurveysController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_survey, only: [:show, :edit, :update, :destroy, :export]
  before_action :set_customisable_questions, only: [:new, :edit]
  before_action :require_ownership, only: [:edit, :update, :destroy]

  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = current_user.admin? ? Survey.all : current_user.surveys
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey       = Survey.new(survey_params)
    @survey.user  = current_user
    @survey.customised_questions.map {|cq| cq.survey = @survey }

    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey, notice: 'Survey was successfully created.' }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { render :edit }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, notice: 'Survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def export
    to_email  = params[:to_email]
    from_date = params[:from_date]
    to_date   = params[:to_date]

    CsvExporterJob.perform_later(to_email, @survey, from_date, to_date)
    redirect_to root_path, notice: "Your CSV is being generated, we will send an email to #{to_email} when it is ready to download"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find_by_uuid(params[:uuid])
    end

    def set_customisable_questions
      @customisable_questions = DemographicQuestion.where(customisable: true)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit(:name, :description, :published,
                                     translations_attributes: [:id, :name, :description, :locale, :_destroy],
                                     customised_questions_attributes: [:id, :text, :demographic_question_id, :locale, :_destroy,
                                       options_attributes: [:id, :optionable_id, :optionable_type, :text, :locale, :_destroy]
                                      ])
    end

    def require_ownership
      unless (current_user == @survey.user) || (current_user.admin?)
        redirect_to root_path, notice: "You are not the owner of that survey or an admin"
      end
    end
end
