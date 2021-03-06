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
#  f1_score          :float
#  f2_score          :float
#  f3_score          :float
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
    language nil
    uuid nil

    after(:create) do |response|
      create_list(:answer, 3, response: response)
    end

    after(:build) do |response|
      build_list(:answer, 3, response: response)
    end
  end
end
