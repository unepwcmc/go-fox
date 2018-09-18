# == Schema Information
#
# Table name: demographic_questions
#
#  id            :integer          not null, primary key
#  text          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  question_type :string
#  validation    :jsonb
#  customisable  :boolean          default(FALSE)
#

require 'test_helper'

class DemographicQuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
