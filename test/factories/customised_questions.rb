# == Schema Information
#
# Table name: customised_questions
#
#  id         :integer          not null, primary key
#  survey_id  :integer
#  text       :string
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

FactoryBot.define do
  factory :customised_question do
    survey nil
    text "MyString"
  end
end
