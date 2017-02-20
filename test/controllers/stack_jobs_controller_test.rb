require 'test_helper'

class StackJobsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stack_jobs_index_url
    assert_response :success
  end

end
