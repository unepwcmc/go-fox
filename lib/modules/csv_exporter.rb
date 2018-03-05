module CsvExporter
  @@batch_size = 250
  @@default_na = "n/a"
  @@questions  = Question.all + DemographicQuestion.all

  def self.export(survey, from_date, to_date)
    filepath  = self.create_filepath
    responses = self.find_responses(survey, from_date, to_date)

    CSV.open(filepath, "wb") do |csv|
      csv << self.headers

      responses.each do |response|
        csv << self.format_response_row(response)
      end
    end

    filepath
  end


  def self.find_responses(survey, from_date, to_date)
    conditions              = {}
    from_date               = Response.first.created_at if from_date.blank?
    to_date                 = DateTime.now              if to_date.blank?
    conditions[:created_at] = from_date..to_date        if (from_date.present? && to_date.present?)
    conditions[:survey]     = survey                    if survey.present?

    Response.where(conditions: conditions).find_in_batches(batch_size: @@batch_size)
  end

  def format_response_row(response, default=@@default_na)
    @@questions.each {|question| response.answer_for(question)&.raw_formatted || default}
  end

  def self.create_filepath
    folder = Rails.root.join("public", "csv_exports")
    FileUtils.mkdir_p(folder)
    folder.join("csv_export_#{DateTime.now.to_i}.csv")
  end

  def self.headers
    @@questions.pluck(:text)
  end

  def self.date_valid?(date)
    # Formats date from params to date object
    return nil if date.blank?
    year, month, day = date&.split("-").map(&:to_i)
    Date.valid_date?(year, month, day)
  end
end
