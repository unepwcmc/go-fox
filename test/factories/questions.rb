# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  weight     :float
#

FactoryBot.define do
  factory :question do
    text "An example question"
    x_weight 0.1234
    y_weight -1.0
    z_weight 0.333
  end
end
