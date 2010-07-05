require 'test_helper'

class EditVersionPrioritiesTest < ActionController::IntegrationTest
  context "as a logged in user" do
    setup do
      @user = login_as_user
    end

    context "updating the priorities" do
      should "respond with unauthorized" do
        put "/version_priorities.js"
        assert_response 403
      end
    end
  end

  context "as an administrator" do
    setup do
      @user = login_as_user
      @user.update_attribute(:admin, true)

      @project1 = Project.generate!
      @project2 = Project.generate!
      @version1 = Version.generate!(:project => @project1)
      @version2 = Version.generate!(:project => @project2)
    end

    should "reprioritize the versions with a :html request" do
      put "/version_priorities", :version => [@version2.id.to_s, @version1.id.to_s]

      assert_response :redirect
      follow_redirect!
      assert_template 'version_priorities/show'
      
      assert_equal 2, @version1.reload.priority
      assert_equal 1, @version2.reload.priority
    end

    should "reprioritize the versions with a :js request" do
      put "/version_priorities.js", :version => [@version2.id.to_s, @version1.id.to_s]
      assert_response :success

      assert_equal 2, @version1.reload.priority
      assert_equal 1, @version2.reload.priority
    end

    should "remove versions not in the list anymore" do
      @version2.insert_at(1)
      assert_equal 1, @version2.reload.priority
      
      put "/version_priorities.js", :version => [@version1.id.to_s]
      assert_response :success

      assert_equal nil, @version2.reload.priority
    end

    should "remove all versions when the list is empty" do
      @version2.insert_at(1)
      assert_equal 1, @version2.reload.priority
      @version1.insert_at(2)
      assert_equal 2, @version1.reload.priority
      
      put "/version_priorities.js"
      assert_response :success

      assert_equal nil, @version1.reload.priority
      assert_equal nil, @version2.reload.priority
    end
  end
  
  def login_as_user
    user = User.generate!(:login => 'existing', :password => 'existing', :password_confirmation => 'existing', :admin => false)
    visit "/login"
    fill_in 'Login', :with => 'existing'
    fill_in 'Password', :with => 'existing'
    click_button 'login'
    assert_response :success
    assert User.current.logged?

    user
  end
end
