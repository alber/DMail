require "application_system_test_case"

class StationsTest < ApplicationSystemTestCase
  setup do
    @station = stations(:one)
  end

  test "visiting the index" do
    visit stations_url
    assert_selector "h1", text: "Stations"
  end

  test "creating a Station" do
    visit stations_url
    click_on "New Station"

    fill_in "Admin", with: @station.admin
    fill_in "Confirmed", with: @station.confirmed
    fill_in "Current weatherscore", with: @station.current_weatherscore
    fill_in "Docked", with: @station.docked_id
    check "Is docked" if @station.is_docked
    check "Is me" if @station.is_me
    fill_in "Lat", with: @station.lat
    fill_in "Location", with: @station.location
    fill_in "Long", with: @station.long
    fill_in "Name", with: @station.name
    fill_in "Parent", with: @station.parent_id
    fill_in "Status", with: @station.status
    fill_in "Tier", with: @station.tier
    fill_in "Total", with: @station.total
    fill_in "Unconfirmed", with: @station.unconfirmed
    click_on "Create Station"

    assert_text "Station was successfully created"
    click_on "Back"
  end

  test "updating a Station" do
    visit stations_url
    click_on "Edit", match: :first

    fill_in "Admin", with: @station.admin
    fill_in "Confirmed", with: @station.confirmed
    fill_in "Current weatherscore", with: @station.current_weatherscore
    fill_in "Docked", with: @station.docked_id
    check "Is docked" if @station.is_docked
    check "Is me" if @station.is_me
    fill_in "Lat", with: @station.lat
    fill_in "Location", with: @station.location
    fill_in "Long", with: @station.long
    fill_in "Name", with: @station.name
    fill_in "Parent", with: @station.parent_id
    fill_in "Status", with: @station.status
    fill_in "Tier", with: @station.tier
    fill_in "Total", with: @station.total
    fill_in "Unconfirmed", with: @station.unconfirmed
    click_on "Update Station"

    assert_text "Station was successfully updated"
    click_on "Back"
  end

  test "destroying a Station" do
    visit stations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Station was successfully destroyed"
  end
end
