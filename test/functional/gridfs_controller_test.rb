require 'test_helper'

class GridfsControllerTest < ActionController::TestCase
  test "should get serve" do
    get :serve
    assert_response :success
  end

end
