# == Schema Information
#
# Table name: surveys
#
#  id          :integer          not null, primary key
#  name        :string
#  published   :boolean
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  uuid        :string           not null
#  description :text
#
# Indexes
#
#  index_surveys_on_user_id  (user_id)
#  index_surveys_on_uuid     (uuid) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Survey < ApplicationRecord
  belongs_to :user
  before_create :set_uuid
  has_many :responses, dependent: :destroy
  translates :name, :description
  accepts_nested_attributes_for :translations

  def to_param
    uuid
  end
end
