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
    when "location_of_organisation"
      location_of_organisation
    when "type_of_organisation"
      type_of_organisation
    when "organisation_funding_sources"
      organisation_funding_sources
    when "wider_network"
      wider_network
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

  def location_of_organisation
    COUNTRIES
  end

  def type_of_organisation
    {
      ngo: "Non Governmental Organisation (NGO)",
      government: "Governmental Organisation",
      intergovernmental: "Intergovernmental Organisation",
      private_sector: "Private Sector",
      inter_organisation_collaboration: "Inter-Organisation group / collaboration",
      university: "University",
      training: "Training College",
      other: "Other (please specify)"
    }
  end

  def organisation_funding_sources
    {
      individual_subscriptions: "Individual member subscriptions",
      small_donations: "Small donations from members of the public",
      large_donations: "Large donations from wealthy individuals and foundations",
      research_grants: "Research grants",
      government_funding: "Government funding",
      commercial_income: "Commercial income",
      corporate_partnerships: "Corporate partnerships/donations",
      intergovernmental_funding: "Intergovernmental funding",
      wider_network: "A wider network or partnership to which the group/organisation belongs",
      other: "Other (please specify)"
    }
  end

  def wider_network
    {
      yes: "Yes",
      no: "No"
    }
  end

end
