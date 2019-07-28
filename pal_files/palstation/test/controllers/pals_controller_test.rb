require 'test_helper'

class PalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pal = pals(:one)
  end

  test "should get index" do
    get pals_url
    assert_response :success
  end

  test "should get new" do
    get new_pal_url
    assert_response :success
  end

  test "should create pal" do
    assert_difference('Pal.count') do
      post pals_url, params: { pal: { flightplan_id: @pal.flightplan_id, lat: @pal.lat, location: @pal.location, long: @pal.long, payload_id: @pal.payload_id, status: @pal.status } }
    end

    assert_redirected_to pal_url(Pal.last)
  end

  test "should show pal" do
    get pal_url(@pal)
    assert_response :success
  end

  test "should get edit" do
    get edit_pal_url(@pal)
    assert_response :success
  end

  test "should update pal" do
    patch pal_url(@pal), params: { pal: { flightplan_id: @pal.flightplan_id, lat: @pal.lat, location: @pal.location, long: @pal.long, payload_id: @pal.payload_id, status: @pal.status } }
    assert_redirected_to pal_url(@pal)
  end

  test "should destroy pal" do
    assert_difference('Pal.count', -1) do
      delete pal_url(@pal)
    end

    assert_redirected_to pals_url
  end
end
