require 'test_helper'

class ResponsesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    5.times {@classification = create(:classification)}
    @user     = create(:user)
    @admin    = create(:admin)
    @survey   = create(:survey, user: @user)
    @response = create(:response, survey: @survey, classification: @classification)
  end

  test "response can only be destroyed by a logged in user" do
    assert_no_difference('Response.count') do
      delete survey_response_url(@survey, @response)
    end
    assert_redirected_to new_user_session_path
  end

  test "response can only be deleted by owner of the survey" do
    survey2         = create(:survey, user: @admin)
    classification2 = create(:classification)
    response2       = create(:response, survey: survey2, classification: classification2)

    sign_in @user
    delete survey_response_url(survey2, response2)
    assert_redirected_to survey_path(survey2)
  end

  test "a user cannot delete another user's responses" do
    user2 = create(:user)

    sign_in user2
    assert_no_difference('Response.count') do
      delete survey_response_url(@survey, @response)
    end
    assert_redirected_to survey_path(@survey)
  end

  test "an admin can delete any response" do
    sign_in @admin

    assert_difference('Response.count', -1) do
      delete survey_response_url(@survey, @response)
    end
  end

  test "show can not be accessed without being logged in" do
    get survey_response_url(@survey, @response)
    assert_redirected_to new_user_session_path
  end

  test "unpublished survey will not allow responses by anyone" do
    survey2 = create(:survey, user: @user, published: false)

    get new_survey_response_path(survey2)
    assert_redirected_to root_path
  end

  test "new can be accessed by anyone" do
    get new_survey_response_path(@survey)
    assert_response :success
  end

  test "post to create action saves a response" do
    answer = build(:answer)
    res = build(:response)

    assert_difference('Response.count', 1) do
      post survey_responses_path(@survey), params: { response: {survey_id: res.survey_id,
                                           answers_attributes: [{raw: answer.raw,
                                                                 answerable_type: answer.answerable_type,
                                                                 answerable_id: answer.answerable_id
                                                                 }]}}
    end

    assert_redirected_to root_path
  end
end
