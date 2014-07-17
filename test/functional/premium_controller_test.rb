require 'test_helper'

class PremiumControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get query" do
    get :query
    assert_response :success
  end

  test "should get videos" do
    get :videos
    assert_response :success
  end

end
