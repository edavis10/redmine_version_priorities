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

  should "allow all logged in users to see the unprioritized versions" do
    @user = login_as_user
    @project1 = Project.generate!
    @project2 = Project.generate!
    @version1 = Version.generate!(:project => @project1)
    @version2 = Version.generate!(:project => @project2)
    @role = Role.generate!(:permissions => [:view_issues])
    Member.generate!(:principal => @user, :roles => [@role], :project => @project1)
    Member.generate!(:principal => @user, :roles => [@role], :project => @project2)
    
    visit "/version_priorities"

    assert_select "#unprioritized-versions" do
      assert_select "li" do
        assert_select "a", :text => /#{@version1.name}/
        assert_select "span", :text => /#{@version1.description}/
      end

      assert_select "li" do
        assert_select "a", :text => /#{@version2.name}/
        assert_select "span", :text => /#{@version2.description}/
      end
    end
    
  end

  should "allow all logged in users to see the prioritized versions" do
    @user = login_as_user
    @project1 = Project.generate!
    @project2 = Project.generate!
    @version1 = Version.generate!(:project => @project1, :priority => 1)
    @version2 = Version.generate!(:project => @project2, :priority => 2)
    @role = Role.generate!(:permissions => [:view_issues])
    Member.generate!(:principal => @user, :roles => [@role], :project => @project1)
    Member.generate!(:principal => @user, :roles => [@role], :project => @project2)
    
    visit "/version_priorities"

    assert_select "#prioritized-versions" do
      assert_select "li" do
        assert_select "a", :text => /#{@version1.name}/
        assert_select "span", :text => /#{@version1.description}/
      end

      assert_select "li" do
        assert_select "a", :text => /#{@version2.name}/
        assert_select "span", :text => /#{@version2.description}/
      end
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
