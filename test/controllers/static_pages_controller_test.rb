require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    # We have already seeded a master survey from database seeds
    #create(:survey, master: true)
    get static_pages_index_url
    assert_response :success
  end
end
