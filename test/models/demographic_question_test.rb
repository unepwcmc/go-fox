# == Schema Information
#
# Table name: demographic_questions
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  question_type :string
#  validation    :jsonb
#

require 'test_helper'

class DemographicQuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
