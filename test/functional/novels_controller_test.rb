require 'test_helper'

class NovelsControllerTest < ActionController::TestCase
  setup do
    @novel = novels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:novels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create novel" do
    assert_difference('Novel.count') do
      post :create, novel: @novel.attributes
    end

    assert_redirected_to novel_path(assigns(:novel))
  end

  test "should show novel" do
    get :show, id: @novel.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @novel.to_param
    assert_response :success
  end

  test "should update novel" do
    put :update, id: @novel.to_param, novel: @novel.attributes
    assert_redirected_to novel_path(assigns(:novel))
  end

  test "should destroy novel" do
    assert_difference('Novel.count', -1) do
      delete :destroy, id: @novel.to_param
    end

    assert_redirected_to novels_path
  end
end
