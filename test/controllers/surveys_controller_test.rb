require 'test_helper'

class SurveysControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user  = create(:user)
    @admin = create(:admin)
  end

  test "cannot access surveys index page when not logged in" do
    get surveys_url
    assert_redirected_to new_user_session_path
  end

  test "admin can see all surveys" do
    create(:survey, user: @user)
    create(:survey, user: @admin)

    sign_in @admin
    get surveys_url
    assert_equal 2, @controller.instance_variable_get("@surveys").count
  end

  test "non admin only sees their own surveys" do
    create(:survey, user: @user)
    create(:survey, user: @admin)

    sign_in @user
    get surveys_url
    assert_equal 1, @controller.instance_variable_get("@surveys").count
  end

  test "admin can edit anyones survey" do
    sign_in @admin
    get edit_survey_url(@survey)
    assert_response :success
  end

  test "non admins can only edit their own surveys" do
    sign_in @user
    get edit_survey_url(@survey2)
    assert_redirected_to root_path
  end

  test "show page for unpublished survey should redirect to root" do
    sign_in @user
    get survey_url(@survey)
    assert_redirected_to root_path
  end

  test "should get index for logged in user" do
    sign_in @user
    get surveys_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user
    get new_survey_url
    assert_response :success
  end

  test "should create survey" do
    sign_in @user
    assert_difference('Survey.count') do
      post surveys_url, params: { survey: { name: @survey.name, published: @survey.published, user_id: @survey.user_id } }
    end

    assert_redirected_to survey_url(Survey.last)
  end

  test "should show survey" do
    sign_in @user2
    get survey_path(@survey2)
    assert_redirected_to survey_path(@survey2)
  end

  test "should get edit" do
    sign_in @user
    get edit_survey_url(@survey)
    assert_response :success
  end

  test "should update survey" do
    sign_in @user
    new_name = "My updated survey"
    patch survey_path(@survey3), params: { survey: { name: new_name, published: true } }
    @survey3.reload
    assert_equal new_name, @survey3.name
  end

  test "should destroy survey" do
    sign_in @user
    assert_difference('Survey.count', -1) do
      delete survey_url(@survey)
    end

    assert_redirected_to surveys_url
  end
end
