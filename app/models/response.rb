# == Schema Information
#
# Table name: responses
#
#  id                :integer          not null, primary key
#  survey_id         :integer
#  ip_address        :string
#  langauge          :string
#  uuid              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  x_axis_scaled     :float
#  y_axis_scaled     :float
#  z_axis_scaled     :float
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

  accepts_nested_attributes_for :answers
  before_create :set_uuid
  before_create :calculate_classification

  def to_param
    uuid
  end

  def calculate_classification
    total_number_questions = Question.count
    x_total_sum = 0
    y_total_sum = 0
    z_total_sum = 0

    self.answers.each do |answer|
      question = answer.question
      # calculate the preliminary values of x, y, z
      # question weight * answer value
      x = question.x_weight * calculate_value(answer.raw) rescue nil
      y = question.y_weight * calculate_value(answer.raw) rescue nil
      z = question.z_weight * calculate_value(answer.raw) rescue nil

      # sum up the totals for each axis
      x_total_sum += x rescue nil
      y_total_sum += y rescue nil
      z_total_sum += z rescue nil
    end

    unless total_number_questions == 0
      self.x_axis_scaled  = x_total_sum / total_number_questions
      self.y_axis_scaled  = y_total_sum / total_number_questions
      self.z_axis_scaled  = z_total_sum / total_number_questions
      self.classification = choose_quadrant
    end
  end

  def calculate_value(raw)
    case raw
    when "Strongly Disagree"
      -1
    when "Disagree"
      -0.5
    when "Agree"
      0.5
    when "Strongly Agree"
      1
    else
      0
    end
  end

  def choose_quadrant
    Classification.find_by(name: "Critical Social Science")
  end
end
