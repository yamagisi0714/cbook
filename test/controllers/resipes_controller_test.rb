require 'test_helper'

class ResipesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get resipes_index_url
    assert_response :success
  end

  test "should get new" do
    get resipes_new_url
    assert_response :success
  end

  test "should get edit" do
    get resipes_edit_url
    assert_response :success
  end

  test "should get show" do
    get resipes_show_url
    assert_response :success
  end

  test "should get destory" do
    get resipes_destory_url
    assert_response :success
  end

end
