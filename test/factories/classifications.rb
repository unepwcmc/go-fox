# == Schema Information
#
# Table name: classifications
#
#  id                  :integer          not null, primary key
#  name                :string
#  description         :text
#  results_description :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryBot.define do
  factory :classification do
    name "MyString"
    description "MyText"
    results_description "MyText"
  end
end
