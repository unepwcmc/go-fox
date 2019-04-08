# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  text        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  weight      :float
#  axis_name   :string
#  equation_id :integer
#

class Question < ApplicationRecord
  has_many :answers, as: :answerable

  translates :text
  accepts_nested_attributes_for :translations

  def question_type
    "Scale"
  end

  def self.required
    pluck(:id)
  end
end
