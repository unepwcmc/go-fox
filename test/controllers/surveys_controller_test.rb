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
    @survey = create(:survey, user: @user)

    sign_in @admin
    get edit_survey_url(@survey)
    assert_response :success
  end

  test "non admins can only edit their own surveys" do
    @survey = create(:survey, user: @admin)

    sign_in @user
    get edit_survey_url(@survey)
    assert_redirected_to root_path
  end

  test "show page for unpublished survey should redirect to root" do
    @survey = create(:survey, user: @user, published: false)

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
      post surveys_url, params: { survey: { name: "My new survey", published: true, user_id: @user.id } }
    end

    assert_redirected_to survey_url(Survey.last)
  end

  test "should show survey" do
    @survey = create(:survey, user: @user, published: true)

    sign_in @user
    get survey_path(@survey)
    assert_response :success
  end

  test "should get edit" do
    @survey = create(:survey, user: @user)

    sign_in @user
    get edit_survey_url(@survey)
    assert_response :success
  end

  test "should update survey" do
    @survey = create(:survey, user: @user)

    sign_in @user
    new_name = "My updated survey"
    patch survey_path(@survey), params: { survey: { name: new_name } }
    @survey.reload
    assert_equal new_name, @survey.name
  end

  test "should destroy survey" do
    @survey = create(:survey, user: @user)

    sign_in @user
    assert_difference('Survey.count', -1) do
      delete survey_url(@survey)
    end

    assert_redirected_to surveys_url
  end
end