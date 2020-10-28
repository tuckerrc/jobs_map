require 'test_helper'

class StackJobsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stack_jobs_index_url
    assert_response :success
  end

  test "should get search" do
    get search_url
    assert_response :success
  end

  test "should get search with params" do
    get search_url params: {"search": "[javascript]"}
    assert_response :success
  end

end
