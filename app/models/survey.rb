# == Schema Information
#
# Table name: surveys
#
#  id          :integer          not null, primary key
#  name        :string
#  published   :boolean
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  uuid        :string           not null
#  description :text
#  locked      :boolean          default(FALSE)
#  master      :boolean          default(FALSE)
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

class Survey < ApplicationRecord
  before_create :set_uuid

  has_many :responses, dependent: :destroy
  has_many :customised_questions, dependent: :destroy
  belongs_to :user

  translates :name, :description

  accepts_nested_attributes_for :translations
  accepts_nested_attributes_for :customised_questions, allow_destroy: true

  validates_uniqueness_of :master, if: :master

  def to_param
    uuid
  end

  def questions
    # Returns all the questions for this survey,
    # taking into account customised questions,
    # and excluding and demographic questions that they may override.
    customised_questions      = self.customised_questions
    excluded_demographic_ids  = customised_questions.pluck(:demographic_question_id)
    demographic_questions     = DemographicQuestion.all.reject {|question| excluded_demographic_ids.include?(question.id) }

    Question.order("RANDOM()") + demographic_questions + customised_questions
  end

  def self.master_survey
    find_by_master(true)
  end
end
