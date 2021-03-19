module SurveysHelper

  def survey_warning_description(master)
    master ? I18n.t('survey_warning.master_description') : I18n.t('survey_warning.description')
  end

  def multiple_choice_answers(survey, question_id)
    question_answer = survey.settings[question_id]

    if question_answer.is_a? String
      [surveys_data(question_id)[question_answer]].compact
    elsif question_answer.kind_of?(Array)
      question_answer.map{ |k| surveys_data(question_id)[k] }.compact
    else
      []
    end
  end

  def surveys_data(type)
    return [] if type.nil?
    @data = YAML.load(File.open("#{Rails.root}/lib/data/content/surveys-form.yml", 'r'))
    return location_of_organisation if type == "location_of_organisation"
    @data[type]
  end

  private

  def location_of_organisation
    (["More than one country"] << COUNTRIES).flatten
  end

end
