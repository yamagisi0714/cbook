require 'test_helper'

class StepsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get steps_edit_url
    assert_response :success
  end

end
