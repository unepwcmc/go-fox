require 'test_helper'

class Devise::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "user sign in path should return success" do
    get new_user_session_path
    assert_response :success
  end
end

class Devise::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "user sign up path should return success" do
    get new_user_registration_path
    assert_response :success
  end
end
