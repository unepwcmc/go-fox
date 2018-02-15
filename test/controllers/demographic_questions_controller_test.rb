require 'test_helper'

class DemographicQuestionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user  = create(:user)
    @admin = create(:admin)
    @demographic_question = create(:demographic_question)
  end

  test "admin should get index" do
    sign_in @admin
    get demographic_questions_url
    assert_response :success
  end

  test "user should not be able to get index" do
    sign_in @user
    get demographic_questions_url
    assert_redirected_to root_path(locale: :en)
  end

  test "admin should get new" do
    sign_in @admin
    get new_demographic_question_url
    assert_response :success
  end

  test "admin should create demographic_question" do
    sign_in @admin
    assert_difference('DemographicQuestion.count') do
      post demographic_questions_url, params: {
        demographic_question: {
          text: @demographic_question.text,
          question_type: @demographic_question.question_type
          }
        }
    end

    assert_redirected_to demographic_question_url(DemographicQuestion.last, locale: :en)
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
    assert_redirected_to demographic_question_url(@demographic_question, locale: :en)
  end
end
