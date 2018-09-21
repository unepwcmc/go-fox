require 'test_helper'

class Devise::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "user sign in path should return success" do
    get new_user_session_path
    assert_response :success
  end
end

class Devise::SessionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user     = create(:user)
    @admin    = create(:admin)
  end

  test "admin root path should return success" do
    sign_in @admin
    get root_path(locale: :en)
    assert_response :success
  end

  test "user root path should return success" do
    sign_in @user
    get root_path(locale: :en)
    assert_response :success
  end

  test "non logged in user root path should return success" do
    @survey = create(:survey, user: @user, published: true, master: true)
    get root_path(locale: :en)
    assert_response :success
  end
end

class Devise::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "user sign up path should return success" do
    get new_user_registration_path
    assert_response :success
  end
end
