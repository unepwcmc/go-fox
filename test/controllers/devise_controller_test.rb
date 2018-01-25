require 'test_helper'

class DeviseControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::ControllerHelpers

  test "user sign in should return success" do
    get new_user_session_url
    assert_response :success
  end

  test "new user registration should return success" do
    get new_user_registration_url
    assert_response :success
  end

end
