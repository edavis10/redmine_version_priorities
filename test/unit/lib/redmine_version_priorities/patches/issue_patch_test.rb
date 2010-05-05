require File.dirname(__FILE__) + '/../../../../test_helper'

class RedmineVersionPriorities::Patches::IssueTest < ActionController::TestCase

  context "Issue#fixed_version_priority" do
    setup do
      @project = Project.generate!
      @issue = Issue.generate_for_project!(@project)
    end
    
    context "without a fixed version" do
      should "return none" do
        assert @issue.fixed_version.nil?
        assert_equal 'none', @issue.fixed_version_priority
      end
    end

    context "with a fixed version with no priority" do
      should "return none" do
        @issue.update_attribute(:fixed_version, Version.generate!)
        assert @issue.fixed_version.present?
        
        assert_equal 'none', @issue.fixed_version_priority
      end
    end

    context "with a fixed version with a priority" do
      should "return the fixed version" do
        version = Version.generate!(:priority => 4)
        @issue.update_attribute(:fixed_version, version)
        assert @issue.fixed_version.present?
        
        assert_equal version, @issue.fixed_version_priority
      end
      
    end

  end
end
