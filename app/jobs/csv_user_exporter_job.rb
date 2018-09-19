require_relative '../../lib/modules/csv_user_exporter'

class CsvUserExporterJob < ApplicationJob
  queue_as :default

  def perform(to_email)
    filepath = CsvUserExporter.export
    NotificationMailer.csv_exported(filepath.to_s, to_email).deliver_now
  end
end
