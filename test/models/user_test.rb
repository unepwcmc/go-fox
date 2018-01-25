require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "saving a new user" do
    user = FactoryBot.build(:user)
    assert user.save, "User was not saved"
  end
end
