require 'csv'

module CsvExporter
  @@batch_size = 250
  @@default_na = "n/a"
  @@questions  = Question.all + DemographicQuestion.all

  def self.export(survey, from_date, to_date)
    filepath  = self.create_filepath
    responses = self.find_responses(survey, from_date, to_date)

    CSV.open(filepath, "wb", {col_sep: ";"}) do |csv|
      csv << self.headers

      responses.each do |batch|
        batch.each do |response|
          csv << self.format_response_row(response)
        end
      end

    end

    filepath
  end


  def self.find_responses(survey, from_date, to_date)
    conditions              = {}
    from_date               = from_date.present? ? from_date.to_datetime.beginning_of_day : Response.first.created_at
    to_date                 = to_date.present?   ? to_date.to_datetime.end_of_day         : DateTime.now
    conditions[:created_at] = from_date..to_date
    conditions[:survey]     = survey if survey.present?

    Response.where(conditions).find_in_batches(batch_size: @@batch_size)
  end

  def self.format_response_row(response, default=@@default_na)
    @@questions.map {|question| response.answer_for(question)&.raw_formatted || default}
  end

  def self.create_filepath
    folder = Rails.root.join("public", "csv_exports")
    FileUtils.mkdir_p(folder)
    folder.join("csv_export_#{DateTime.now.to_i}.csv")
  end

  def self.headers
    @@questions.pluck(:text).map {|text| text.delete(",")}
  end
end
