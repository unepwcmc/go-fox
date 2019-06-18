require 'csv'
require 'securerandom'

module CsvUserExporter
  extend CsvHelpers

  @@batch_size  = 250
  @@remove_keys = ["encrypted_password", "reset_password_token",
                   "reset_password_sent_at", "remember_created_at"]
  @@attributes  = User.new.attributes.keys.delete_if{ |attribute| @@remove_keys.include? (attribute) }
  @@default_na  = "n/a"

  def self.export
    filepath  = self.create_filepath("csv_user_export")
    users = self.find_users

    CSV.open(filepath, "wb", {col_sep: ";"}) do |csv|
      csv << @@attributes

      users.each do |batch|
        batch.each do |user|
          csv << self.format_user_row(user)
        end
      end

    end

    filepath
  end

  def self.find_users
    User.all.find_in_batches(batch_size: @@batch_size)
  end

  def self.format_user_row(user, default=@@default_na)
    @@attributes.map{ |attr| user.send(attr) || default }
  end
end
