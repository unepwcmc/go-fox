# == Schema Information
#
# Table name: demographic_questions
#
#  id         :integer          not null, primary key
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DemographicQuestion < ApplicationRecord
  has_many :answers, as: :answerable
  translates :text
end
