require 'test_helper'

class WaypointsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @waypoint = waypoints(:one)
  end

  test "should get index" do
    get waypoints_url
    assert_response :success
  end

  test "should get new" do
    get new_waypoint_url
    assert_response :success
  end

  test "should create waypoint" do
    assert_difference('Waypoint.count') do
      post waypoints_url, params: { waypoint: { flightplan_id: @waypoint.flightplan_id, lat: @waypoint.lat, long: @waypoint.long, step: @waypoint.step } }
    end

    assert_redirected_to waypoint_url(Waypoint.last)
  end

  test "should show waypoint" do
    get waypoint_url(@waypoint)
    assert_response :success
  end

  test "should get edit" do
    get edit_waypoint_url(@waypoint)
    assert_response :success
  end

  test "should update waypoint" do
    patch waypoint_url(@waypoint), params: { waypoint: { flightplan_id: @waypoint.flightplan_id, lat: @waypoint.lat, long: @waypoint.long, step: @waypoint.step } }
    assert_redirected_to waypoint_url(@waypoint)
  end

  test "should destroy waypoint" do
    assert_difference('Waypoint.count', -1) do
      delete waypoint_url(@waypoint)
    end

    assert_redirected_to waypoints_url
  end
end
