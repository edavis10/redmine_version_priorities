require 'test_helper'

class ViewVersionPrioritiesTest < ActionController::IntegrationTest
  should "not show the menu item to users not logged in" do
    visit "/"
    assert_response :success
    assert_select "#top-menu a.version-priorities", :count => 0
  end

  should "show the menu item to logged in users" do
    login_as_user
    
    visit "/"
    assert_response :success
    assert_select "#top-menu a.version-priorities", :count => 1
  end

  should "allow all logged in users to visit the prioritized versions panel" do
    login_as_user

    visit '/'
    click_link "Version Priorities"
    assert_response :success
    assert_equal "/version_priorities", current_url
  end

  should "allow all logged in users to see the priorities"

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
