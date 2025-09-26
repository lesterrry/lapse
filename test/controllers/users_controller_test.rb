require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get single' do
    get users_single_url
    assert_response :success
  end
end
