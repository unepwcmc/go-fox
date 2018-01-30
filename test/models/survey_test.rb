# == Schema Information
#
# Table name: surveys
#
#  id         :integer          not null, primary key
#  name       :string
#  published  :boolean
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  uuid       :string           not null
#
# Indexes
#
#  index_surveys_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  setup do
    @user = FactoryBot.create(:user)
  end

  test "saving a survey" do
    survey = FactoryBot.build(:survey, user: @user)
    assert survey.save, "Survey was not saved"
  end

  test "creating a survey generate and assigns a uuid" do
    survey = FactoryBot.create(:survey, user: @user)
    assert_not_nil survey.uuid, "UUID was not generated or saved for a survey"
  end
end
