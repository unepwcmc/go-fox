class Admin::ResponsesController < ApplicationController
  def index
    @responses = Response.all
  end

  def export
    CsvExporterJob.perform_later(current_user.email)
    redirect_to root_path, notice: "Your CSV is being generated, we will send an email to #{to_email} when it is ready to download"
  end
end
