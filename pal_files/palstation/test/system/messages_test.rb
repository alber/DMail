require "application_system_test_case"

class MessagesTest < ApplicationSystemTestCase
  setup do
    @message = messages(:one)
  end

  test "visiting the index" do
    visit messages_url
    assert_selector "h1", text: "Messages"
  end

  test "creating a Message" do
    visit messages_url
    click_on "New Message"

    fill_in "Author", with: @message.author
    fill_in "Authored", with: @message.authored
    fill_in "Authored at", with: @message.authored_at
    fill_in "Body", with: @message.body
    fill_in "Data", with: @message.data
    fill_in "Destination", with: @message.destination_id
    fill_in "Final destination", with: @message.final_destination_id
    fill_in "Format", with: @message.format
    check "Is received" if @message.is_received
    check "Is sent" if @message.is_sent
    fill_in "Jump", with: @message.jump
    fill_in "Manifest", with: @message.manifest
    fill_in "Received at", with: @message.received_at
    fill_in "Received by", with: @message.received_by
    fill_in "Received by me", with: @message.received_by_me
    click_on "Create Message"

    assert_text "Message was successfully created"
    click_on "Back"
  end

  test "updating a Message" do
    visit messages_url
    click_on "Edit", match: :first

    fill_in "Author", with: @message.author
    fill_in "Authored", with: @message.authored
    fill_in "Authored at", with: @message.authored_at
    fill_in "Body", with: @message.body
    fill_in "Data", with: @message.data
    fill_in "Destination", with: @message.destination_id
    fill_in "Final destination", with: @message.final_destination_id
    fill_in "Format", with: @message.format
    check "Is received" if @message.is_received
    check "Is sent" if @message.is_sent
    fill_in "Jump", with: @message.jump
    fill_in "Manifest", with: @message.manifest
    fill_in "Received at", with: @message.received_at
    fill_in "Received by", with: @message.received_by
    fill_in "Received by me", with: @message.received_by_me
    click_on "Update Message"

    assert_text "Message was successfully updated"
    click_on "Back"
  end

  test "destroying a Message" do
    visit messages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Message was successfully destroyed"
  end
end
