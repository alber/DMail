require "application_system_test_case"

class PalsTest < ApplicationSystemTestCase
  setup do
    @pal = pals(:one)
  end

  test "visiting the index" do
    visit pals_url
    assert_selector "h1", text: "Pals"
  end

  test "creating a Pal" do
    visit pals_url
    click_on "New Pal"

    fill_in "Flightplan", with: @pal.flightplan_id
    fill_in "Lat", with: @pal.lat
    fill_in "Location", with: @pal.location
    fill_in "Long", with: @pal.long
    fill_in "Payload", with: @pal.payload_id
    fill_in "Status", with: @pal.status
    click_on "Create Pal"

    assert_text "Pal was successfully created"
    click_on "Back"
  end

  test "updating a Pal" do
    visit pals_url
    click_on "Edit", match: :first

    fill_in "Flightplan", with: @pal.flightplan_id
    fill_in "Lat", with: @pal.lat
    fill_in "Location", with: @pal.location
    fill_in "Long", with: @pal.long
    fill_in "Payload", with: @pal.payload_id
    fill_in "Status", with: @pal.status
    click_on "Update Pal"

    assert_text "Pal was successfully updated"
    click_on "Back"
  end

  test "destroying a Pal" do
    visit pals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pal was successfully destroyed"
  end
end
