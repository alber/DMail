require 'test_helper'

class StationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @station = stations(:one)
  end

  test "should get index" do
    get stations_url
    assert_response :success
  end

  test "should get new" do
    get new_station_url
    assert_response :success
  end

  test "should create station" do
    assert_difference('Station.count') do
      post stations_url, params: { station: { admin: @station.admin, confirmed: @station.confirmed, current_weatherscore: @station.current_weatherscore, docked_id: @station.docked_id, is_docked: @station.is_docked, is_me: @station.is_me, lat: @station.lat, location: @station.location, long: @station.long, name: @station.name, parent_id: @station.parent_id, status: @station.status, tier: @station.tier, total: @station.total, unconfirmed: @station.unconfirmed } }
    end

    assert_redirected_to station_url(Station.last)
  end

  test "should show station" do
    get station_url(@station)
    assert_response :success
  end

  test "should get edit" do
    get edit_station_url(@station)
    assert_response :success
  end

  test "should update station" do
    patch station_url(@station), params: { station: { admin: @station.admin, confirmed: @station.confirmed, current_weatherscore: @station.current_weatherscore, docked_id: @station.docked_id, is_docked: @station.is_docked, is_me: @station.is_me, lat: @station.lat, location: @station.location, long: @station.long, name: @station.name, parent_id: @station.parent_id, status: @station.status, tier: @station.tier, total: @station.total, unconfirmed: @station.unconfirmed } }
    assert_redirected_to station_url(@station)
  end

  test "should destroy station" do
    assert_difference('Station.count', -1) do
      delete station_url(@station)
    end

    assert_redirected_to stations_url
  end
end
