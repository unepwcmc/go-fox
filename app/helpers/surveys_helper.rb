module SurveysHelper
  def surveys_data(type)
    case type
    when "default_language"
      default_language
    when "participant_level_of_study"
      participant_level_of_study
    when "participant_specialism"
      participant_specialism
    when "follow_up_session"
      follow_up_session
    when "anonymity"
      anonymity
    else []
    end
  end

  private

  def default_language
    {
      en: "English",
      es: "Spanish",
      fr: "French"
    }
  end

  def participant_level_of_study
    {
      undergraduate: "Undergraduate degree",
      postgraduate: "Postgraduate degree",
      vocational: "Vocational qualification",
      training: "Training course",
      other: "Other (please specify):"
    }
  end

  def participant_specialism
    {
      interdisciplinary: "Interdisciplinary",
      biological: "Biological sciences",
      non_biological: "Non-biological natural sciences",
      social: "Social sciences",
      humanities: "Humanities",
      na: "Not applicable"
    }
  end

  def follow_up_session
    {
      yes: "Yes",
      no: "No"
    }
  end

  def anonymity
    {
      yes: "Yes",
      no: "No"
    }
  end
end
