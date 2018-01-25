# == Schema Information
#
# Table name: surveys
#
#  id         :integer          not null, primary key
#  name       :string
#  published  :boolean
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_surveys_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :survey do
    name "MyString"
    published false
    user nil
  end
end
