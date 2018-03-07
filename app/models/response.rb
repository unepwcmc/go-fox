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

class Response < ApplicationRecord
  belongs_to :survey
  belongs_to :classification
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers, reject_if: lambda { |a| a[:raw].blank? }

  before_validation :set_uuid, on: :create
  before_validation :assign_classification, on: :create

  validates :uuid, presence: true

  def to_param
    uuid
  end

  def answer_for(question)
    if question.class.name == "DemographicQuestion"
      customised_question = question.customised_questions.find_by(survey: self.survey, demographic_question: question)
      question = customised_question unless customised_question.nil?
    end

    self.answers.find_by(answerable: question)
  end

  def total_scores
    scores = self.answers.where(answerable_type: "Question").map(&:score)

    x_total = scores.sum {|score| score[:x]}
    y_total = scores.sum {|score| score[:y]}
    z_total = scores.sum {|score| score[:z]}

    {x: x_total, y: y_total, z: z_total}
  end

  def scaled_scores
    total_number_of_questions = Question.count.to_f
    total_scores              = self.total_scores

    {
      x: total_scores[:x] / total_number_of_questions,
      y: total_scores[:y] / total_number_of_questions,
      z: total_scores[:z] / total_number_of_questions
    }
  end

  def assign_classification
    self.x_score        = scaled_scores[:x]
    self.y_score        = scaled_scores[:y]
    self.z_score        = scaled_scores[:z]
    self.classification = choose_classification_quadrant
  end

  def choose_classification_quadrant
    x = self.x_score
    y = self.y_score

    if x.between?(-1, 0) && y.between?(-1, 0)
      Classification.find_by(name: "Critical Social Science")
    elsif x.between?(0, 1) && y.between?(-1, 0)
      Classification.find_by(name: "Traditional Conservation")
    elsif x.between?(-1, 0) && y.between?(0, 1)
      Classification.find_by(name: "New Conservation")
    elsif x.between?(0, 1) && y.between?(0, 1)
      Classification.find_by(name: "Market Biocentrism")
    else
      Classification.find_by(name: "Undecided")
    end
  end
end
