# == Schema Information
#
# Table name: customised_questions
#
#  id         :integer          not null, primary key
#  survey_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_customised_questions_on_survey_id  (survey_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_id => surveys.id)
#

require 'test_helper'

class CustomisedQuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
