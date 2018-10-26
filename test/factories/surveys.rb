# == Schema Information
#
# Table name: surveys
#
#  id         :integer          not null, primary key
#  published  :boolean
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

survey_settings = {
  course_url: "No",
  hope_to_achieve: "Cool!",
  default_language: "fr",
  survey_previous_id: "12345667",
  participant_org_name: "Yes"
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
end
