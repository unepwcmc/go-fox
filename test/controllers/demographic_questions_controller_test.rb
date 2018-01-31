require 'test_helper'

class DemographicQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user  = create(:user)
    @admin = create(:admin)
    @demographic_question = demographic_questions(:one)
  end

  test "admin should get index" do
    sign_in @admin
    get demographic_questions_url
    assert_response :success
  end

  test "admin should get new" do
    sign_in @admin
    get new_demographic_question_url
    assert_response :success
  end

  test "admin should create demographic_question" do
    sign_in @admin
    assert_difference('DemographicQuestion.count') do
      post demographic_questions_url, params: { demographic_question: { text: @demographic_question.text } }
    end

    assert_redirected_to demographic_question_url(DemographicQuestion.last)
  end

  test "admin should show demographic_question" do
    sign_in @admin
    get demographic_question_url(@demographic_question)
    assert_response :success
  end

  test "admin should get edit" do
    sign_in @admin
    get edit_demographic_question_url(@demographic_question)
    assert_response :success
  end

  test "admin should update demographic_question" do
    sign_in @admin
    patch demographic_question_url(@demographic_question), params: { demographic_question: { text: @demographic_question.text } }
    assert_redirected_to demographic_question_url(@demographic_question)
  end

  test "admin should destroy demographic_question" do
    sign_in @admin
    assert_difference('DemographicQuestion.count', -1) do
      delete demographic_question_url(@demographic_question)
    end

    assert_redirected_to demographic_questions_url
  end
end
