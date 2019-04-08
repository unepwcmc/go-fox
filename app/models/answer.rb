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
    question_type = self.question.question_type

    if ["Checkbox", "Multiple Select Box"].include?(question_type)
      self.raw.join(", ")
    else
      self.raw
    end
  end

  def value
    case self.raw
    when "Strongly Disagree"  then -3
    when "Disagree"           then -2
    when "Slightly Disagree"  then -1
    when "Slightly Agree"     then 1
    when "Agree"              then 2
    when "Strongly Agree"     then 3
    else
      0.0
    end
  end
end
