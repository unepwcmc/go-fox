# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  x_weight   :float
#  y_weight   :float
#  z_weight   :float
#

FactoryBot.define do
  factory :question do
    text "An example question"
    x_weight 0.1234
    y_weight -1.0
    z_weight 0.333
  end
end
