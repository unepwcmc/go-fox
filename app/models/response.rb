# == Schema Information
#
# Table name: responses
#
#  id            :integer          not null, primary key
#  survey_id     :integer
#  ip_address    :string
#  langauge      :string
#  uuid          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  x_axis_scaled :float
#  y_axis_scaled :float
#  z_axis_scaled :float
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
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers
  before_create :set_uuid

  def to_param
    uuid
  end
end
