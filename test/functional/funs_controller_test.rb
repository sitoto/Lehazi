require 'test_helper'

class FunsControllerTest < ActionController::TestCase
  setup do
    @fun = funs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:funs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fun" do
    assert_difference('Fun.count') do
      post :create, fun: @fun.attributes
    end

    assert_redirected_to fun_path(assigns(:fun))
  end

  test "should show fun" do
    get :show, id: @fun.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fun.to_param
    assert_response :success
  end

  test "should update fun" do
    put :update, id: @fun.to_param, fun: @fun.attributes
    assert_redirected_to fun_path(assigns(:fun))
  end

  test "should destroy fun" do
    assert_difference('Fun.count', -1) do
      delete :destroy, id: @fun.to_param
    end

    assert_redirected_to funs_path
  end
end
