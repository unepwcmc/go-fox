# == Schema Information
#
# Table name: surveys
#
#  id         :integer          not null, primary key
#  published  :boolean          default(TRUE)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  uuid       :string           not null
#  locked     :boolean          default(FALSE)
#  master     :boolean          default(FALSE)
#  settings   :jsonb
#
# Indexes
#
#  index_surveys_on_user_id  (user_id)
#  index_surveys_on_uuid     (uuid) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

conservation_activities = [
  "research",
  "policy_advocacy"
]

survey_settings = {
  course_url: "https://www.unep-wcmc.org",
  hope_to_achieve: "Awesome things!",
  default_language: "fr",
  survey_previous_id: "12345667",
  participant_org_name: "UNEP-WCMC",
  kind_of_conservation_activities: conservation_activities
}.to_json

FactoryBot.define do
  factory :survey do
    name "Survey name"
    published true
    association :user, factory: :user
    uuid nil
    locked false
    master false
    settings survey_settings
  end

  factory :master_survey, class: Survey do
    name "Master survey"
    published true
    association :user, factory: :user
    uuid nil
    locked false
    master true
    settings survey_settings
  end

end
