# == Schema Information
#
# Table name: classifications
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

classification_names = [
  "Critical Social Science",
  "Market Biocentrism",
  "New Conservation",
  "Traditional Conservation",
  "Undecided"
]

FactoryBot.define do
  factory :classification do
    sequence(:name) { |n| classification_names[n-1] }
    description "description"
    results_description "results description"
  end
end
