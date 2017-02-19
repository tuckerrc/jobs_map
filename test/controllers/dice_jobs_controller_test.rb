require 'test_helper'

class DiceJobsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dice_jobs_index_url
    assert_response :success
  end

end
