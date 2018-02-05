require 'test_helper'

class ResponsesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user   = create(:user)
    @admin  = create(:admin)
    @survey = create(:survey, user: @user)
  end

  test "response can only be destroyed by a logged in user" do
    @response = create(:response, survey: @survey)

    delete survey_response_url(@survey, @response)
    assert_redirected_to new_user_session_path
  end

  test "response can only be deleted by owner of the survey" do
    @survey2  = create(:survey, user: @admin)
    @response = create(:response, survey: @survey2)

    sign_in @user
    delete survey_response_url(@survey2, @response)
    assert_redirected_to survey_path(@survey2)
  end

  test "a user cannot delete another user's responses" do
    @response = create(:response, survey: @survey)
    @user2    = create(:user)

    sign_in @user2
    delete survey_response_url(@survey, @response)
    assert_redirected_to survey_path(@survey)
  end

  test "an admin can delete any response" do
    @response = create(:response, survey: @survey)

    sign_in @admin

    assert_difference('Response.count', -1) do
      delete survey_response_url(@survey, @response)
    end
  end

  test "show can not be accessed without being logged in" do
    @response = create(:response, survey: @survey)

    get survey_response_url(@survey, @response)
    assert_redirected_to new_user_session_path
  end

  test "new can be accessed by anyone" do
    get new_survey_response_path(@survey)
    assert_response :success
  end

  test "create can be accessed by anyone" do
    assert_difference('Response.count', 1) do
      post survey_responses_path(@survey), params: { }
    end

    assert_redirected_to root_path
  end
end
