require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'database_cleaner'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  DatabaseCleaner.clean
  Rails.application.load_seed

  5.times { FactoryBot.create(:classification) }
end
