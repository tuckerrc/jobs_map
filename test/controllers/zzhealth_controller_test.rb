require 'test_helper'

class ZzhealthControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get zzhealth_url
    assert_response :success
  end
end
