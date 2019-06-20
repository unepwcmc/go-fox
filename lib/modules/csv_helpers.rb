module CsvHelpers
  def create_filepath(filename)
    folder = Rails.root.join("public", "csv_exports")
    FileUtils.mkdir_p(folder)
    folder.join("#{filename}_#{Time.now.strftime("%y-%m-%d_%H-%M-%S")}_#{SecureRandom.urlsafe_base64(5)}.csv")
  end
end