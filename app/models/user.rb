# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  username               :string           not null
#  organisation_name      :string           not null
#  admin                  :boolean          default(FALSE), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  use_type               :integer          default("organisational")
#  org_type               :string           default(""), not null
#  org_type_other         :string           default("")
#  country                :string           default("")
#  wider_network          :boolean          default(FALSE), not null
#  wider_network_details  :string           default("")
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :organisation_name, presence: true
  ORG_TYPES = { school: 'School', university: 'University/College', consultancy: 'Consultancy',
                government: 'Government', intergovernmental: 'Intergovernmental',
                ngo: 'NGO', private_sector: 'Private sector',
                inter_organisation_collaboration: 'Inter-organisation collaboration',
                other: 'Other (specify)' }
  validates :org_type, inclusion: { in: ORG_TYPES.keys.map(&:to_s) }, unless: :admin
  validates :wider_network, inclusion: { in: [ true, false ] }, unless: :admin

  has_many :surveys

  enum use_type:           [:organisational, :educational]
  enum wider_network_type: [:yes, :no]


  def self.org_types
    ORG_TYPES.map {|k,v| [v,k]}
  end

  ORG_TYPES.keys.each do |type|
    define_method("is_#{type}?") { self.org_type == type.to_s }
    scope type, -> { where(org_type: type) }
    self.const_set(type.upcase, type)
  end
end
