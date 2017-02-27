require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "should get sale_order" do
    get :sale_order
    assert_response :success
  end

  test "should get customer_registered" do
    get :customer_registered
    assert_response :success
  end

  test "should get coupons_used" do
    get :coupons_used
    assert_response :success
  end

end
