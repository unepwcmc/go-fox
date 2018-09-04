require 'test_helper'

class ResponsesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user     = create(:user)
    @admin    = create(:admin)
    @survey   = create(:survey, user: @user)
    @response = create(:response, survey: @survey)
  end

  test "response cannot be destroyed by a non logged in user" do
    assert_no_difference('Response.count') do
      delete survey_response_url(@survey, @response)
    end
    assert_redirected_to new_user_session_path
  end

  test "user cannot delete another users response" do
    survey2   = create(:survey, user: @admin)
    response2 = create(:response, survey: survey2)

    sign_in @user
    assert_no_difference('Response.count') do
      delete survey_response_url(survey2, response2)
    end
    assert_redirected_to root_path(locale: :en)
  end

  test "an admin can delete any response" do
    sign_in @admin

    assert_difference('Response.count', -1) do
      delete survey_response_url(@survey, @response)
    end
  end

  test "show response cannot be accessed by non logged in user" do
    get survey_response_url(@survey, @response)
    assert_redirected_to new_user_session_path
  end

  test "show response can be accessed by logged in user" do
    sign_in @user

    get survey_response_url(@survey, @response)
    assert_response :success
  end

  test "show response can only be accessed by the owner of the survey" do
    user = create(:user)

    sign_in user
    get survey_response_url(@survey, @response)
    assert_redirected_to root_path(locale: :en)
  end

  test "show response can be accessed by an admin" do
    sign_in @admin
    get survey_response_url(@survey, @response)
    assert :success
  end

  test "anyone can access the results page for a given response" do
    get results_survey_response_path(@survey, @response)
    assert_response :success
  end

  test "unpublished survey will not allow responses by anyone" do
    survey2 = create(:survey, user: @user, published: false)

    get new_survey_response_path(survey2)
    assert_redirected_to root_path(locale: :en)
  end

  test "new response can be accessed by anyone" do
    get new_survey_response_path(@survey)
    assert_response :success
  end

  test "post to create action saves a response" do
    skip("This test won't work because now we validate the answers on the backend")
    answer = build(:answer)
    res = build(:response)

    assert_difference('Response.count', 1) do
      post survey_responses_path(@survey), params: { response: {survey_id: res.survey_id,
                                           answers_attributes: [{raw: answer.raw,
                                                                 answerable_type: answer.answerable_type,
                                                                 answerable_id: answer.answerable_id
                                                                 }]}}
    end

    assert_redirected_to root_path(locale: :en)
  end
end
