require 'test_helper'

class RentInfosControllerTest < ActionController::TestCase
  setup do
    @rent_info = rent_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rent_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rent_info" do
    assert_difference('RentInfo.count') do
      post :create, rent_info: @rent_info.attributes
    end

    assert_redirected_to rent_info_path(assigns(:rent_info))
  end

  test "should show rent_info" do
    get :show, id: @rent_info.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rent_info.to_param
    assert_response :success
  end

  test "should update rent_info" do
    put :update, id: @rent_info.to_param, rent_info: @rent_info.attributes
    assert_redirected_to rent_info_path(assigns(:rent_info))
  end

  test "should destroy rent_info" do
    assert_difference('RentInfo.count', -1) do
      delete :destroy, id: @rent_info.to_param
    end

    assert_redirected_to rent_infos_path
  end
end
