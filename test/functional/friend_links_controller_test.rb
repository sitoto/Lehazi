require 'test_helper'

class FriendLinksControllerTest < ActionController::TestCase
  setup do
    @friend_link = friend_links(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:friend_links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create friend_link" do
    assert_difference('FriendLink.count') do
      post :create, friend_link: @friend_link.attributes
    end

    assert_redirected_to friend_link_path(assigns(:friend_link))
  end

  test "should show friend_link" do
    get :show, id: @friend_link.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @friend_link.to_param
    assert_response :success
  end

  test "should update friend_link" do
    put :update, id: @friend_link.to_param, friend_link: @friend_link.attributes
    assert_redirected_to friend_link_path(assigns(:friend_link))
  end

  test "should destroy friend_link" do
    assert_difference('FriendLink.count', -1) do
      delete :destroy, id: @friend_link.to_param
    end

    assert_redirected_to friend_links_path
  end
end
