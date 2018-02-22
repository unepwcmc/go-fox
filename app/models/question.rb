# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  x_weight   :float
#  y_weight   :float
#  z_weight   :float
#

class Question < ApplicationRecord
  has_many :answers, as: :answerable

  translates :text
  accepts_nested_attributes_for :translations

  def question_type
    "Scale"
  end
end
