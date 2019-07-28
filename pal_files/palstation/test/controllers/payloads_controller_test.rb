require 'test_helper'

class PayloadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payload = payloads(:one)
  end

  test "should get index" do
    get payloads_url
    assert_response :success
  end

  test "should get new" do
    get new_payload_url
    assert_response :success
  end

  test "should create payload" do
    assert_difference('Payload.count') do
      post payloads_url, params: { payload: { created_at: @payload.created_at, is_received: @payload.is_received, is_sent: @payload.is_sent, pal_id: @payload.pal_id } }
    end

    assert_redirected_to payload_url(Payload.last)
  end

  test "should show payload" do
    get payload_url(@payload)
    assert_response :success
  end

  test "should get edit" do
    get edit_payload_url(@payload)
    assert_response :success
  end

  test "should update payload" do
    patch payload_url(@payload), params: { payload: { created_at: @payload.created_at, is_received: @payload.is_received, is_sent: @payload.is_sent, pal_id: @payload.pal_id } }
    assert_redirected_to payload_url(@payload)
  end

  test "should destroy payload" do
    assert_difference('Payload.count', -1) do
      delete payload_url(@payload)
    end

    assert_redirected_to payloads_url
  end
end
