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
  before_validation :calculate_classification

  def to_param
    uuid
  end

  def total_scores
    x_total = self.answers.sum {|score| score[:x] }
    y_total = self.answers.sum {|score| score[:y] }
    z_total = self.answers.sum {|score| score[:z] }

    {x_total: x_total, y_total: y_total, z_total: z_total}
  end

  def scaled_scores
    total_number_of_questions = Question.count.to_f

    {
      x_scaled: total_scores[:x] / total_number_of_questions,
      y_scaled: total_scores[:y] / total_number_of_questions,
      z_scaled: total_scores[:z] / total_number_of_questions,
    }
  end

  def assign_classification
    self.x_score = scaled_scores[:x]
    self.y_score = scaled_scores[:y]
    self.z_score = scaled_scores[:z]

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
