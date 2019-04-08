require 'test_helper'

class DeviseTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "Signing in an existing user redirects you to the home page" do
    sign_in create(:user)
    get root_path
    assert_not(@response.cookies.empty?, "User session cookie was not set, the user wasn't signed in")
    assert_equal("/", path, "Root path for logged in user is not the home page")
  end

  test "Signing up a new user redirects you to the home page" do
    get new_user_registration_path
    assert(:success)

    assert_difference 'User.count', 1 do
      user = build(:user)

      post user_registration_path, params: {
        user: {
          username: user.username,
          organisation_name: user.organisation_name,
          email: user.email,
          password: user.password,
          password_confirmation: user.password,
          org_type: user.org_type,
          wider_network: user.wider_network
        }
      }
    end

    follow_redirect!
    assert_not(@response.cookies.empty?, "User session cookie was not set, the user wasn't signed in")
    assert_equal("/", path, "Root path for logged in user is not the home page")
  end
end
