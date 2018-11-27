require 'test_helper'

class MygroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get mygroups_show_url
    assert_response :success
  end

  test "should get update" do
    get mygroups_update_url
    assert_response :success
  end

  test "should get destroy" do
    get mygroups_destroy_url
    assert_response :success
  end

end
