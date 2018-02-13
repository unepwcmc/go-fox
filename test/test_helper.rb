require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  def default_url_options
    { locale: I18n.locale }
  end

  5.times { FactoryBot.create(:classification) }
end
