require 'test_helper'

class FlightplansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @flightplan = flightplans(:one)
  end

  test "should get index" do
    get flightplans_url
    assert_response :success
  end

  test "should get new" do
    get new_flightplan_url
    assert_response :success
  end

  test "should create flightplan" do
    assert_difference('Flightplan.count') do
      post flightplans_url, params: { flightplan: { last_waypoint: @flightplan.last_waypoint, step_waypoint: @flightplan.step_waypoint, updated_at: @flightplan.updated_at, updated_by: @flightplan.updated_by, updated_by_me: @flightplan.updated_by_me, waypoint_count: @flightplan.waypoint_count } }
    end

    assert_redirected_to flightplan_url(Flightplan.last)
  end

  test "should show flightplan" do
    get flightplan_url(@flightplan)
    assert_response :success
  end

  test "should get edit" do
    get edit_flightplan_url(@flightplan)
    assert_response :success
  end

  test "should update flightplan" do
    patch flightplan_url(@flightplan), params: { flightplan: { last_waypoint: @flightplan.last_waypoint, step_waypoint: @flightplan.step_waypoint, updated_at: @flightplan.updated_at, updated_by: @flightplan.updated_by, updated_by_me: @flightplan.updated_by_me, waypoint_count: @flightplan.waypoint_count } }
    assert_redirected_to flightplan_url(@flightplan)
  end

  test "should destroy flightplan" do
    assert_difference('Flightplan.count', -1) do
      delete flightplan_url(@flightplan)
    end

    assert_redirected_to flightplans_url
  end
end
