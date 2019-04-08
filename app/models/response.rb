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
    self.answers.find_by(answerable: question)
  end

  def assign_classification
    self.f1_score        = calculate_f1
    self.f2_score        = calculate_f2
    self.f3_score        = calculate_f3
    self.classification  = choose_classification_quadrant
  end

  # Approx F1 = -1.487 + (0.162 x q4) + (0.123 x q18) + (0.082 x q20) + (0.157 x q24) +
  # (0.142 x q29) + (0.232 x q30) + (0.082 x q32)
  def calculate_f1
    equation_ids = Question.where(axis_name: F1).pluck(:equation_id)
    -1.487 + calculate_weighted_question_summation(equation_ids)
  end

  # Approx F2 = -1.413 + (0.076 x q3) + (0.260 x q6) + (0.071 x q9) + (0.276 x q10) +
  # (0.079 x q16) + (0.119 x q21)
  def calculate_f2
    equation_ids = Question.where(axis_name: F2).pluck(:equation_id)
    -1.413 + calculate_weighted_question_summation(equation_ids)
  end

  # Approx F3 = -0.360 + (0.226 x q14) + (0.250 x q15) + (-0.083 x q22) + (0.126 x q28) +
  # (0.096 x q31)
  def calculate_f3
    equation_ids = Question.where(axis_name: F3).pluck(:equation_id)
    -0.360 + calculate_weighted_question_summation(equation_ids)
  end

  def response_value(response_answer)
    case response_answer
    when "Strongly Disagree"
      -2
    when "Disagree"
      -1
    when "Slightly Disagree"
      -0.5
    when "Neither Agree nor Disagree"
      0
    when "Slightly Agree"
      0.5
    when "Agree"
      1
    when "Strongly Agree"
      2
    else
      0
    end
  end

  def calculate_weighted_question_summation(equation_ids)
    sum = 0

    equation_ids.each do |equation_id|
      question = Question.find_by(equation_id: equation_id)
      answer_value = answers.select { |a| a.answerable_id == question.id }.first.raw
      sum += (question.weight * response_value(answer_value)) rescue nil
    end

    sum
  end

  def choose_classification_quadrant
    f1 = self.f1_score
    f2 = self.f2_score
    f3 = self.f2_score

    # TODO: Create new classification
    # if x.between?(-1, 0) && y.between?(-1, 0)
    #   Classification.find_by(name: "Critical Social Science")
    # elsif x.between?(0, 1) && y.between?(-1, 0)
    #   Classification.find_by(name: "Traditional Conservation")
    # elsif x.between?(-1, 0) && y.between?(0, 1)
    #   Classification.find_by(name: "New Conservation")
    # elsif x.between?(0, 1) && y.between?(0, 1)
    #   Classification.find_by(name: "Market Biocentrism")
    # else
    #   Classification.find_by(name: "Undecided")
    # end
    Classification.find_by(name: "Critical Social Science")
  end
end
