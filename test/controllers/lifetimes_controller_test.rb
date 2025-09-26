require 'test_helper'

class LifetimesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get lifetimes_index_url
    assert_response :success
  end
end
