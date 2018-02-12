# == Schema Information
#
# Table name: responses
#
#  id                :integer          not null, primary key
#  survey_id         :integer
#  ip_address        :string
#  language          :string
#  uuid              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  x_score           :float
#  y_score           :float
#  z_score           :float
#  classification_id :integer
#
# Indexes
#
#  index_responses_on_classification_id  (classification_id)
#  index_responses_on_survey_id          (survey_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_id => surveys.id)
#

require 'test_helper'

class ResponseTest < ActiveSupport::TestCase
  setup do
    @user   = FactoryBot.create(:user)
    @survey = FactoryBot.create(:survey, user: @user)
  end

  test "saving a response" do
    response = FactoryBot.build(:response, survey: @survey)
    assert response.save, "Response was not saved"
  end

  test "creating a response generates and assigns a uuid" do
    response = FactoryBot.create(:response)
    assert_not_nil response.uuid, "UUID was not generated or saved for a response"
  end

  test "creating a response assigns a classification" do
    response = FactoryBot.create(:response)
    assert_not_nil response.x_score
    assert_not_nil response.y_score
    assert_not_nil response.z_score
    assert_not_nil response.classification_id
  end
end
