require "test_helper"

class DerivationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get derivation_index_url
    assert_response :success
  end
end
