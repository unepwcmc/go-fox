# == Schema Information
#
# Table name: responses
#
#  id         :integer          not null, primary key
#  survey_id  :integer
#  ip_address :string
#  langauge   :string
#  uuid       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_responses_on_survey_id  (survey_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_id => surveys.id)
#

class Response < ApplicationRecord
  belongs_to :survey
end
