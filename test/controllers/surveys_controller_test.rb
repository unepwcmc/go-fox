require 'test_helper'

class SurveysControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user  = create(:user)
    @admin = create(:admin)
    @master_survey = create(:master_survey)
  end

  test "cannot access surveys index page when not logged in" do
    get surveys_url
    assert_redirected_to new_user_session_path
  end

  test "admin see other surveys with the :user params" do
    survey = create(:survey, user: @user)
    create(:survey, user: @admin)

    sign_in @admin
    get surveys_url(user: @user.id)
    assert_equal 1, @controller.instance_variable_get("@surveys").count
    assert_equal survey, @controller.instance_variable_get("@surveys").first
  end

  test "user only sees their own surveys" do
    create(:survey, user: @user)
    create(:survey, user: @admin)

    sign_in @user
    get surveys_url
    assert_equal 1, @controller.instance_variable_get("@surveys").count
  end

  test "admin can edit anyones survey" do
    skip("skipping this test for now due to an issue with rails: https://github.com/rails/rails/issues/27788")
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

  test "should get show page for logged in user" do
    @survey = create(:survey, user: @user)

    sign_in @user
    get survey_url(@survey)
    assert_response :success
  end

  test "show page should list responses for that survey" do
    @survey         = create(:survey, user: @user)
    @response       = create(:response, survey: @survey)

    sign_in @user
    get survey_url(@survey)
    assert_equal 1, @controller.instance_variable_get("@survey").responses.count
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

  test "can create survey with two custom questions" do
    sign_in @user
    assert_difference('Survey.count') do
      post surveys_url, params: { survey: { name: "My new survey", published: true, user_id: @user.id, customised_questions_attributes: [ {text: "A question?"}, {text: "another question"} ] } }
    end
    assert_redirected_to survey_url(Survey.last)
    assert_equal 2, Survey.last.customised_questions.count
  end

  test "can't create survey with more than three custom questions" do
    sign_in @user
    assert_difference('Survey.count', 0) do
      post surveys_url, params: { survey: { name: "My new survey", published: true, user_id: @user.id, customised_questions_attributes: [ {text: "A question?"}, {text: "another question"}, {text: "third question"}, {text: "were either of those actually questions?"} ] } }
      assert_response :success # not sure why failed validation returns 200 !?
    end
  end

  test "can create survey with custom question with 2 options" do
    sign_in @user
    assert_difference('Survey.count') do
      post surveys_url, params: { survey: { name: "My new survey", published: true, user_id: @user.id, customised_questions_attributes: [ {text: "A question?", options_attributes: [ {text: "True"}, {text: "False"} ] } ] } }
    end
    assert_redirected_to survey_url(Survey.last)
    assert_equal 1, Survey.last.customised_questions.count
    assert_equal 2, Survey.last.customised_questions.last.options.count
  end

  test "can'y create survey with custom question with 11 options" do
    sign_in @user
    assert_difference('Survey.count',0) do
      post surveys_url, params: { survey: { name: "My new survey", published: true, user_id: @user.id, customised_questions_attributes: [ {text: "How many african swallos does it take to carry a large coconut??",
options_attributes: [ {text: "0"}, {text: "1"} , {text: "3"}, {text: "3"}, {text: "4"}, {text: "5"}, {text: "6"}, {text: "7"}, {text: "8"}, {text: "9"}, {text: "10"}] } ] } }
    end
    assert_response :success # not sure why failed validation returns 200 !?
  end

  test "should show survey" do
    @survey = create(:survey, user: @user, published: true)

    sign_in @user
    get survey_path(@survey)
    assert_response :success
  end

  test "default survey should load master survey for user" do
    sign_in @user
    get new_survey_response_path(Survey.master_survey)
    assert_response :success
  end

  test "default survey should load master survey for admin" do
    sign_in @admin
    get new_survey_response_path(Survey.master_survey)
    assert_response :success
  end

  test "default survey should load master survey for anonymous user" do
    get new_survey_response_path(Survey.master_survey)
    assert_response :success
  end

  test "should get edit" do
    skip("skipping this test for now due to an issue with rails: https://github.com/rails/rails/issues/27788")
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
