require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'database_cleaner'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  5.times { FactoryBot.create(:classification) }
end
