require 'test_helper'

class ClassificationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @classification = create(:classification)
    @user  = create(:user)
    @admin = create(:admin)
  end

  test "should get index" do
    sign_in @admin
    get classifications_url
    assert_response :success
  end

  test "should get new" do
    sign_in @admin
    get new_classification_url
    assert_response :success
  end

  test "should create classification" do
    sign_in @admin
    assert_difference('Classification.count') do
      post classifications_url, params: { classification: { description: @classification.description, name: @classification.name, results_description: @classification.results_description } }
    end

    assert_redirected_to classification_url(Classification.last, locale: :en)
  end

  test "should show classification" do
    sign_in @admin
    get classification_url(@classification)
    assert_response :success
  end

  test "should get edit" do
    sign_in @admin
    get edit_classification_url(@classification)
    assert_response :success
  end

  test "should update classification" do
    sign_in @admin
    patch classification_url(@classification), params: { classification: { description: @classification.description, name: @classification.name, results_description: @classification.results_description } }
    assert_redirected_to classification_url(@classification, locale: :en)
  end
end
