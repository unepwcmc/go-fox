# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :question do
    text "An example question"
  end
end
