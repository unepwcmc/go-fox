# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  weight     :float            default(0.0)
#  axis_name  :string           default("")
#

FactoryBot.define do
  factory :question do
    text "An example question"
    weight 0.1234
  end
end
