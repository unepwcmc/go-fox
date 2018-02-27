# == Schema Information
#
# Table name: customised_questions
#
#  id                      :integer          not null, primary key
#  demographic_question_id :integer
#  survey_id               :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_customised_questions_on_demographic_question_id  (demographic_question_id)
#  index_customised_questions_on_survey_id                (survey_id)
#
# Foreign Keys
#
#  fk_rails_...  (demographic_question_id => demographic_questions.id)
#  fk_rails_...  (survey_id => surveys.id)
#

FactoryBot.define do
  factory :customised_question do
    demographic_question nil
    survey nil
    text "MyString"
  end
end
