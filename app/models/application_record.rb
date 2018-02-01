class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private
    def set_uuid
      loop do
        self.uuid = SecureRandom.urlsafe_base64
        break unless self.class.where(uuid: uuid).exists?
      end
    end
end
