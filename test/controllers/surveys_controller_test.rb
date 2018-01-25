require 'test_helper'

class SurveysControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user   = create(:user)
    @survey = create(:survey, user: @user)
  end

  test "cannot access surveys index page when not logged in" do
    get surveys_url
    assert_redirected_to new_user_session_path
  end

  test "admin can see all surveys" do
    assert false
  end

  test "non admin only sees their own surveys" do
    assert false
  end

  test "admin can edit anyones survey" do
    assert false
  end

  test "non admins can only edit their own surveys" do
    assert false
  end

  test "show page for unpublished survey should redirect to root" do
    assert false
  end

  test "should get index for logged in user" do
    sign_in @user
    get surveys_url
    assert_response :success
  end

  test "should get new" do
    get new_survey_url
    assert_response :success
  end

  test "should create survey" do
    assert_difference('Survey.count') do
      post surveys_url, params: { survey: { name: @survey.name, published: @survey.published, user_id: @survey.user_id } }
    end

    assert_redirected_to survey_url(Survey.last)
  end

  test "should show survey" do
    get survey_url(@survey)
    assert_response :success
  end

  test "should get edit" do
    get edit_survey_url(@survey)
    assert_response :success
  end

  test "should update survey" do
    patch survey_url(@survey), params: { survey: { name: @survey.name, published: @survey.published, user_id: @survey.user_id } }
    assert_redirected_to survey_url(@survey)
  end

  test "should destroy survey" do
    assert_difference('Survey.count', -1) do
      delete survey_url(@survey)
    end

    assert_redirected_to surveys_url
  end
end
