# == Schema Information
#
# Table name: demographic_questions
#
#  id         :integer          not null, primary key
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :demographic_question do
    text "An example demographic question"
  end
end
