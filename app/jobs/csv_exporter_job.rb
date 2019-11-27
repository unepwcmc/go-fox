require_relative '../../lib/modules/csv_exporter'

class CsvExporterJob < ApplicationJob
  queue_as :default

  def perform(to_email, survey=nil, from_date=nil, to_date=nil, user_id=nil)
    filepath = CsvExporter.export(survey, from_date, to_date, User.find_by(email: to_email).id)
    NotificationMailer.csv_exported(filepath.to_s, to_email).deliver_now
  end
end
