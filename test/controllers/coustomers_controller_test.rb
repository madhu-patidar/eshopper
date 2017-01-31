require 'test_helper'

class CoustomersControllerTest < ActionController::TestCase
  setup do
    @coustomer = coustomers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coustomers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coustomer" do
    assert_difference('Coustomer.count') do
      post :create, coustomer: {  }
    end

    assert_redirected_to coustomer_path(assigns(:coustomer))
  end

  test "should show coustomer" do
    get :show, id: @coustomer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coustomer
    assert_response :success
  end

  test "should update coustomer" do
    patch :update, id: @coustomer, coustomer: {  }
    assert_redirected_to coustomer_path(assigns(:coustomer))
  end

  test "should destroy coustomer" do
    assert_difference('Coustomer.count', -1) do
      delete :destroy, id: @coustomer
    end

    assert_redirected_to coustomers_path
  end
end
