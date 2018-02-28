class CsvExporterJob < ApplicationJob
  queue_as :default

  def perform(to_email, survey, from_date, to_date)
    filepath = CsvExporter.export(survey, from_date, to_date)
    NotificationMailer.csv_exported_email(filepath.to_s, to_email).deliver_now
  end
end
