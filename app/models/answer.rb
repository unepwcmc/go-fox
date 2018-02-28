# == Schema Information
#
# Table name: answers
#
#  id              :integer          not null, primary key
#  response_id     :integer
#  raw             :jsonb
#  answerable_type :string
#  answerable_id   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_answers_on_answerable_type_and_answerable_id  (answerable_type,answerable_id)
#  index_answers_on_response_id                        (response_id)
#
# Foreign Keys
#
#  fk_rails_...  (response_id => responses.id)
#

class Answer < ApplicationRecord
  belongs_to :response
  belongs_to :answerable, polymorphic: true

  validates :raw, :answerable_type, :answerable_id, presence: true

  serialize :raw

  def question
    answerable
  end

  def raw_formatted
    if ["Checkbox", "Multiple Select Box"].include?(question_type)
      self.raw.join(", ")
    else
      self.raw
    end
  end

  def value
    case self.raw
    when "Strongly Disagree"  then -1.0
    when "Disagree"           then -0.5
    when "Agree"              then 0.5
    when "Strongly Agree"     then 1.0
    else
      0.0
    end
  end

  def score
    # Only return a score for scale answers using the Question class
    return nil if self.answerable_type != "Question"

    question  = self.question
    value     = self.value

    {
      x: value * question.x_weight,
      y: value * question.y_weight,
      z: value * question.z_weight,
    }
  end
end
