require 'csv'

module CsvExporter
  @@batch_size = 250
  @@default_na = "n/a"
  @@questions  = Question.all + DemographicQuestion.all

  def self.export(survey=nil, from_date=nil, to_date=nil)
    begin
      filepath  = self.create_filepath
      responses = self.find_responses(survey, from_date, to_date)

      CSV.open(filepath, "wb", {col_sep: ";"}) do |csv|
        csv << self.headers

        responses.each do |batch|
          batch.each do |response|
            row = []
            row << self.format_response_row(response) << self.format_scores(response)
            csv << row.flatten
          end
        end

      end

    rescue Exception => e
      Appsignal.send_error(e)
    end

    filepath
  end

  def self.find_responses(survey=nil, from_date=nil, to_date=nil)
    conditions              = {}
    from_date               = from_date.present? ? from_date.to_datetime.beginning_of_day : Response.first.created_at
    to_date                 = to_date.present?   ? to_date.to_datetime.end_of_day         : DateTime.now
    conditions[:created_at] = from_date..to_date
    conditions[:survey]     = survey if survey.present?

    begin
      Response.where(conditions).find_in_batches(batch_size: @@batch_size)
    rescue Exception => e
      Appsignal.send_error(e)
    end
  end

  def self.format_response_row(response, default=@@default_na)
    begin
      @@questions.map {|question| response.answer_for(question)&.raw_formatted || default}
    rescue Exception => e
      Appsignal.send_error(e)
    end
  end

  def self.format_scores(response, default=@@default_na)
    row = []
    begin
      row << (response.f1_score || default) << (response.f2_score || default) << (response.f3_score || default)
      row
    rescue Exception => e
      Appsignal.send_error(e)
    end
  end

  def self.create_filepath
    folder = Rails.root.join("public", "csv_exports")
    FileUtils.mkdir_p(folder)
    folder.join("csv_export_#{DateTime.now.to_i}.csv")
  end

  def self.headers
    results = []
    question_headers = @@questions.pluck(:text).map {|text| text.delete(",")}
    customised_question_headers = []
    score_headers    = ["F1", "F2", "F3"]

    results << question_headers << customised_question_headers << score_headers
    results.flatten
  end
end
