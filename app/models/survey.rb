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
#  uuid       :string           not null
#
# Indexes
#
#  index_surveys_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Survey < ApplicationRecord
  belongs_to :user
  before_create :set_uuid

  def to_param
    uuid
  end

  private
    def set_uuid
      loop do
        self.uuid = SecureRandom.urlsafe_base64
        break unless Survey.where(uuid: uuid).exists?
      end
    end

end
