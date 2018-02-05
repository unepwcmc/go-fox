require 'test_helper'

class ResponsesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user  = create(:user)
    @admin = create(:admin)
  end

  test "response can only be destroyed by a logged in user" do
    @survey   = create(:survey, user: @user)
    @response = create(:response, survey: @survey)

    delete survey_response_url(@survey, @response)
    assert_redirected_to new_user_session_path
  end

  test "response can only be deleted by owner of the survey" do
    @survey   = create(:survey, user: @admin)
    @response = create(:response, survey: @survey)

    sign_in @user
    delete survey_response_url(@survey, @response)
    assert_redirected_to survey_path(@survey)
  end

  test "a user cannot delete another user's reponses" do
    assert false
  end

  test "an admin can delete any response" do
    assert false
  end

  test "show can not be accessed wihtout being logged in" do
    assert false
  end

  test "new can be accessed by anyone" do
    assert false
  end

  test "create can be accessed by anyone" do
    assert false
  end
end
