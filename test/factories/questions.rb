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

FactoryBot.define do
  factory :question do
    text "An example question"
  end
end
