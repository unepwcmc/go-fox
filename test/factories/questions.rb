# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  weight      :float
#  axis_name   :string
#  equation_id :integer
#

FactoryBot.define do
  factory :question do
    text "An example question"
    weight 0.1234
    axis_name F1
    equation_id 30
  end
end
