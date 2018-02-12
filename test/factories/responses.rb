# == Schema Information
#
# Table name: responses
#
#  id                :integer          not null, primary key
#  survey_id         :integer
#  ip_address        :string
#  langauge          :string
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

FactoryBot.define do
  factory :response do
    association :survey, factory: :survey
    ip_address nil
    langauge nil
    uuid nil
  end
end
