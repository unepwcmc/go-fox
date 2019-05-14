require 'csv'

module CsvExporter
  @@batch_size = 250
  @@default_na = "n/a"
  @@questions  = Question.all + DemographicQuestion.all
  @@responses  = nil

  def self.export(survey=nil, from_date=nil, to_date=nil)
    begin
      filepath  = self.create_filepath
      @@responses = self.find_responses(survey, from_date, to_date)

      CSV.open(filepath, "wb", {col_sep: ";"}) do |csv|
        csv << self.headers

        @@responses.each do |batch|
          batch.each do |response|
            row = []
            row << response.survey_id << self.format_response_row(response) << self.format_customised_questions(response) << self.format_scores(response)
            csv << row.flatten
          end
        end

      end

    rescue => e
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
    rescue => e
      Appsignal.send_error(e)
    end
  end

  def self.format_response_row(response, default=@@default_na)
    begin
      @@questions.map {|question| response.answer_for(question)&.raw_formatted || default}
    rescue => e
      Appsignal.send_error(e)
    end
  end

  def self.format_scores(response, default=@@default_na)
    row = []
    begin
      row << (response.f1_score || default) << (response.f2_score || default) << (response.f3_score || default)
      row
    rescue => e
      Appsignal.send_error(e)
    end
  end

  def self.format_customised_questions(response, default=@@default_na)
    begin
      survey = Survey.find(response.survey_id)
      customised_questions = CustomisedQuestion.where(survey_id: survey.id)
      return customised_question_responses_na(0) if customised_questions.empty?
   
      customised_question_row = []

      customised_questions.each do |cq|
        text = CustomisedQuestion::Translation.where(id: cq.id).pluck(:text)
        options = []
        options_ids = cq.options.pluck(:id)
        options << Option::Translation.where(id: options_ids).pluck(:text).join(",")
        answer = response.answer_for(cq)&.raw_formatted || default
        customised_question_row << text << options << answer
      end

      customised_question_row << customised_question_responses_na(customised_question_row.length)
      customised_question_row

    rescue => e
      Appsignal.send_error(e)
    end
  end

  def self.customised_question_responses_na(response_length)
    row = []
    (9 - response_length).times { row << 'n/a' }
    row
  end

  def self.create_filepath
    folder = Rails.root.join("public", "csv_exports")
    FileUtils.mkdir_p(folder)
    folder.join("csv_export_#{DateTime.now.to_s}.csv")
  end

  def self.headers
    begin
      results = []
      survey_id_header = "Survey ID"
      question_headers = @@questions.pluck(:text).map {|text| text.delete(",")}
      score_headers = ["F1", "F2", "F3"]
      customised_question_headers = ["Customised Question 1: Title", "Customised Question 1: Options", "Customised Question 1: Answer",
                                     "Customised Question 2: Title", "Customised Question 2: Options", "Customised Question 2: Answer",
                                     "Customised Question 3: Title", "Customised Question 3: Options", "Customised Question 3: Answer"]

      results << survey_id_header << question_headers << customised_question_headers << score_headers
      results.flatten
    rescue => e
      Appsignal.send_error(e)
    end
  end
end
