require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @message = messages(:one)
  end

  test "should get index" do
    get messages_url
    assert_response :success
  end

  test "should get new" do
    get new_message_url
    assert_response :success
  end

  test "should create message" do
    assert_difference('Message.count') do
      post messages_url, params: { message: { author: @message.author, authored: @message.authored, authored_at: @message.authored_at, body: @message.body, data: @message.data, destination_id: @message.destination_id, final_destination_id: @message.final_destination_id, format: @message.format, is_received: @message.is_received, is_sent: @message.is_sent, jump: @message.jump, manifest: @message.manifest, received_at: @message.received_at, received_by: @message.received_by, received_by_me: @message.received_by_me } }
    end

    assert_redirected_to message_url(Message.last)
  end

  test "should show message" do
    get message_url(@message)
    assert_response :success
  end

  test "should get edit" do
    get edit_message_url(@message)
    assert_response :success
  end

  test "should update message" do
    patch message_url(@message), params: { message: { author: @message.author, authored: @message.authored, authored_at: @message.authored_at, body: @message.body, data: @message.data, destination_id: @message.destination_id, final_destination_id: @message.final_destination_id, format: @message.format, is_received: @message.is_received, is_sent: @message.is_sent, jump: @message.jump, manifest: @message.manifest, received_at: @message.received_at, received_by: @message.received_by, received_by_me: @message.received_by_me } }
    assert_redirected_to message_url(@message)
  end

  test "should destroy message" do
    assert_difference('Message.count', -1) do
      delete message_url(@message)
    end

    assert_redirected_to messages_url
  end
end
