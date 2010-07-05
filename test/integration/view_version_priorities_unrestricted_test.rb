require 'test_helper'

class ViewVersionPrioritiesUnrestrictedTest < ActionController::IntegrationTest
  should "allow all logged in users to see the unprioritized versions without view_issues permission" do
    Setting['plugin_redmine_version_priorities'] = {'restrictions' => 'none'}
    @user = login_as_user
    @project1 = Project.generate!
    @project2 = Project.generate!
    @version1 = Version.generate!(:project => @project1, :description => 'Open')
    @version2 = Version.generate!(:project => @project2, :description => 'Locked', :status => 'locked')
    @closed_version = Version.generate!(:project => @project2, :description => 'Closed', :status => 'closed')
    @role = Role.generate!(:permissions => []) # Note: no permissions
    Member.generate!(:principal => @user, :roles => [@role], :project => @project1)
    Member.generate!(:principal => @user, :roles => [@role], :project => @project2)
    
    visit "/version_priorities"

    assert_select "#unprioritized-versions" do
      assert_select "li" do
        assert_select "span", :text => /#{@version1.reload.name}/
        assert_select "span", :text => /#{@version1.description}/
      end

      assert_select "li" do
        assert_select "span", :text => /#{@version2.reload.name}/
        assert_select "span", :text => /#{@version2.description}/
      end

      assert_select "li" do
        assert_select "span", :text => /#{@closed_version.reload.name}/, :count => 0
        assert_select "span", :text => /#{@closed_version.description}/, :count => 0
      end

    end
    
  end

  should "allow all logged in users to see the prioritized versions" do
    Setting['plugin_redmine_version_priorities'] = {'restrictions' => 'none'}
    @user = login_as_user
    @project1 = Project.generate!
    @project2 = Project.generate!
    @version1 = Version.generate!(:project => @project1, :priority => 1)
    @version2 = Version.generate!(:project => @project2, :priority => 2, :status => 'locked')
    @role = Role.generate!(:permissions => []) # Note: no permissions
    Member.generate!(:principal => @user, :roles => [@role], :project => @project1)
    Member.generate!(:principal => @user, :roles => [@role], :project => @project2)
    
    visit "/version_priorities"

    assert_select "#prioritized-versions" do
      assert_select "li" do
        assert_select "span", :text => /#{@version1.name}/
        assert_select "span", :text => /#{@version1.description}/
      end

      assert_select "li" do
        assert_select "span", :text => /#{@version2.name}/
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
