# == Schema Information
#
# Table name: demographic_questions
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  question_type :string
#  validation    :jsonb
#  customisable  :boolean          default(FALSE)
#

FactoryBot.define do
  factory :demographic_question do
    text "An example demographic question"
    question_type "Radio button"
  end
end
