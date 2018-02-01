# == Schema Information
#
# Table name: answers
#
#  id              :integer          not null, primary key
#  response_id     :integer
#  raw             :jsonb
#  answerable_type :string
#  answerable_id   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_answers_on_answerable_type_and_answerable_id  (answerable_type,answerable_id)
#  index_answers_on_response_id                        (response_id)
#
# Foreign Keys
#
#  fk_rails_...  (response_id => responses.id)
#

FactoryBot.define do
  factory :answer do
    association :answerable, factory: :question
    response nil
    raw ""
  end
end
