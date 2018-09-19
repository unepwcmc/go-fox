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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "saving a new user" do
    user = FactoryBot.build(:user)
    assert user.save, "User was not saved"
  end
end
