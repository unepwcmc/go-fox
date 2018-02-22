# == Schema Information
#
# Table name: customised_questions
#
#  id                      :integer          not null, primary key
#  demographic_question_id :integer
#  survey_id               :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_customised_questions_on_demographic_question_id  (demographic_question_id)
#  index_customised_questions_on_survey_id                (survey_id)
#
# Foreign Keys
#
#  fk_rails_...  (demographic_question_id => demographic_questions.id)
#  fk_rails_...  (survey_id => surveys.id)
#

class CustomisedQuestion < ApplicationRecord
  has_many :answers, as: :answerable
  has_many :options, as: :optionable
  belongs_to :demographic_question
  belongs_to :survey

  translates :text
  accepts_nested_attributes_for :translations
  accepts_nested_attributes_for :options

  def question_type
    self.demographic_question.question_type
  end
end
