require 'test_helper'

module RightManager
  class RightsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @right = right_manager_rights(:one)
    end

    test "should get index" do
      get rights_url
      assert_response :success
    end

    test "should get new" do
      get new_right_url
      assert_response :success
    end

    test "should create right" do
      assert_difference('Right.count') do
        post rights_url, params: { right: { description: @right.description, name: @right.name } }
      end

      assert_redirected_to right_url(Right.last)
    end

    test "should show right" do
      get right_url(@right)
      assert_response :success
    end

    test "should get edit" do
      get edit_right_url(@right)
      assert_response :success
    end

    test "should update right" do
      patch right_url(@right), params: { right: { description: @right.description, name: @right.name } }
      assert_redirected_to right_url(@right)
    end

    test "should destroy right" do
      assert_difference('Right.count', -1) do
        delete right_url(@right)
      end

      assert_redirected_to rights_url
    end
  end
end
