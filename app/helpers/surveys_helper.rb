module SurveysHelper
  def radio_button_data(type)
    case type
    when "default_language"
      default_language
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
end
