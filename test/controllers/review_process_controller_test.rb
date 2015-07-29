require 'test_helper'

class ReviewProcessControllerTest < ActionController::TestCase
  test "should get submit_work" do
    get :submit_work
    assert_response :success
  end

  test "should get list_submissions" do
    get :list_submissions
    assert_response :success
  end

end
