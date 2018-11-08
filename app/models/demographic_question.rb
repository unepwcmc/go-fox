# == Schema Information
#
# Table name: demographic_questions
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  question_type :string
#  validation    :jsonb
#  customisable  :boolean          default(FALSE)
#

class DemographicQuestion < ApplicationRecord
  has_many :answers, as: :answerable
  has_many :options, as: :optionable, dependent: :destroy
  #has_many :customised_questions

  validates :question_type, presence: true

  translates :text

  accepts_nested_attributes_for :translations

  def self.required
    where(validation: {required: true}.to_json).pluck(:id)
  end
end
