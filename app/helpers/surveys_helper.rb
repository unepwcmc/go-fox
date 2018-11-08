module SurveysHelper

  def surveys_data(type)
    @data = YAML.load(File.open("#{Rails.root}/lib/data/content/surveys-form.yml", 'r'))
    return [] if type.nil?
    return location_of_organisation if type == "location_of_organisation"
    @data[type]
  end

  private

  def location_of_organisation
    (["More than one country"] << COUNTRIES).flatten
  end

end
