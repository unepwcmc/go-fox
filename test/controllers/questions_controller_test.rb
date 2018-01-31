require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user     = create(:user)
    @admin    = create(:admin)
    @question = create(:question)
  end

  test "admin should get index" do
    sign_in @admin
    get questions_url
    assert_response :success
  end

  test "user should not be able to get index" do
    sign_in @user
    get questions_url
    assert_redirected_to root_path
  end

  test "admin should get new" do
    sign_in @admin
    get new_question_url
    assert_response :success
  end

  test "admin should create question" do
    sign_in @admin
    assert_difference('Question.count') do
      post questions_url, params: { question: { text: @question.text } }
    end

    assert_redirected_to question_url(Question.last)
  end

  test "admin should show question" do
    sign_in @admin
    get question_url(@question)
    assert_response :success
  end

  test "admin should get edit" do
    sign_in @admin
    get edit_question_url(@question)
    assert_response :success
  end

  test "admin should update question" do
    sign_in @admin
    patch question_url(@question), params: { question: { text: @question.text } }
    assert_redirected_to question_url(@question)
  end

  test "admin should destroy question" do
    sign_in @admin
    assert_difference('Question.count', -1) do
      delete question_url(@question)
    end

    assert_redirected_to questions_url
  end
end
