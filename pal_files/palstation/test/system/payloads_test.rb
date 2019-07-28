require "application_system_test_case"

class PayloadsTest < ApplicationSystemTestCase
  setup do
    @payload = payloads(:one)
  end

  test "visiting the index" do
    visit payloads_url
    assert_selector "h1", text: "Payloads"
  end

  test "creating a Payload" do
    visit payloads_url
    click_on "New Payload"

    fill_in "Created at", with: @payload.created_at
    check "Is received" if @payload.is_received
    check "Is sent" if @payload.is_sent
    fill_in "Pal", with: @payload.pal_id
    click_on "Create Payload"

    assert_text "Payload was successfully created"
    click_on "Back"
  end

  test "updating a Payload" do
    visit payloads_url
    click_on "Edit", match: :first

    fill_in "Created at", with: @payload.created_at
    check "Is received" if @payload.is_received
    check "Is sent" if @payload.is_sent
    fill_in "Pal", with: @payload.pal_id
    click_on "Update Payload"

    assert_text "Payload was successfully updated"
    click_on "Back"
  end

  test "destroying a Payload" do
    visit payloads_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Payload was successfully destroyed"
  end
end
