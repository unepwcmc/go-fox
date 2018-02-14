# == Schema Information
#
# Table name: demographic_questions
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string
#  validation :jsonb
#

FactoryBot.define do
  factory :demographic_question do
    text "An example demographic question"
  end
end
