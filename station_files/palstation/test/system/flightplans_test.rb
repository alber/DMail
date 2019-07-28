require "application_system_test_case"

class FlightplansTest < ApplicationSystemTestCase
  setup do
    @flightplan = flightplans(:one)
  end

  test "visiting the index" do
    visit flightplans_url
    assert_selector "h1", text: "Flightplans"
  end

  test "creating a Flightplan" do
    visit flightplans_url
    click_on "New Flightplan"

    fill_in "Last waypoint", with: @flightplan.last_waypoint
    fill_in "Step waypoint", with: @flightplan.step_waypoint
    fill_in "Updated at", with: @flightplan.updated_at
    fill_in "Updated by", with: @flightplan.updated_by
    fill_in "Updated by me", with: @flightplan.updated_by_me
    fill_in "Waypoint count", with: @flightplan.waypoint_count
    click_on "Create Flightplan"

    assert_text "Flightplan was successfully created"
    click_on "Back"
  end

  test "updating a Flightplan" do
    visit flightplans_url
    click_on "Edit", match: :first

    fill_in "Last waypoint", with: @flightplan.last_waypoint
    fill_in "Step waypoint", with: @flightplan.step_waypoint
    fill_in "Updated at", with: @flightplan.updated_at
    fill_in "Updated by", with: @flightplan.updated_by
    fill_in "Updated by me", with: @flightplan.updated_by_me
    fill_in "Waypoint count", with: @flightplan.waypoint_count
    click_on "Update Flightplan"

    assert_text "Flightplan was successfully updated"
    click_on "Back"
  end

  test "destroying a Flightplan" do
    visit flightplans_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Flightplan was successfully destroyed"
  end
end
