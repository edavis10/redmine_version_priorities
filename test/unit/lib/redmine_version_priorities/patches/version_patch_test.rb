require File.dirname(__FILE__) + '/../../../../test_helper'

class RedmineVersionPriorities::Patches::VersionTest < ActionController::TestCase

  context "Version" do
    context "#position" do
      should 'use acts_as_list' do
        assert Version.new.acts_as_list_class
      end
    end

    should "not add items to the list by default" do
      @version = Version.generate!
      assert_equal nil, @version.priority
    end
  end
end
