require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    create(:survey)
    get static_pages_index_url
    assert_response :success
  end
end
