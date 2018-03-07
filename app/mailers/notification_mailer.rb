class NotificationMailer < ApplicationMailer
  def csv_exported(filepath, to_email)
    @file = Pathname.new(filepath)
    mail(to: to_email, subject: "Your CSV has finished exporting")
  end
end
