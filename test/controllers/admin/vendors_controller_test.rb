require "test_helper"

class Admin::VendorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_vendor = admin_vendors(:one)
  end

  test "should get index" do
    get admin_vendors_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_vendor_url
    assert_response :success
  end

  test "should create admin_vendor" do
    assert_difference("Admin::Vendor.count") do
      post admin_vendors_url, params: { admin_vendor: { address: @admin_vendor.address, name: @admin_vendor.name } }
    end

    assert_redirected_to admin_vendor_url(Admin::Vendor.last)
  end

  test "should show admin_vendor" do
    get admin_vendor_url(@admin_vendor)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_vendor_url(@admin_vendor)
    assert_response :success
  end

  test "should update admin_vendor" do
    patch admin_vendor_url(@admin_vendor), params: { admin_vendor: { address: @admin_vendor.address, name: @admin_vendor.name } }
    assert_redirected_to admin_vendor_url(@admin_vendor)
  end

  test "should destroy admin_vendor" do
    assert_difference("Admin::Vendor.count", -1) do
      delete admin_vendor_url(@admin_vendor)
    end

    assert_redirected_to admin_vendors_url
  end
end
