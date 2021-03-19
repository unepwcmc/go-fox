module SurveysHelper

  def survey_warning_description(master)
    master ? I18n.t('survey_warning.master_description') : I18n.t('survey_warning.description')
  end

  def geographical_scopes(survey)
    geographical_scope = survey.settings["geographical_scope"]

    if geographical_scope.is_a? String
      [surveys_data("geographical_scope")[geographical_scope]].compact
    else
      geographical_scope.map{ |k| surveys_data("geographical_scope")[k] }.compact
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
