module SurveysHelper

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
