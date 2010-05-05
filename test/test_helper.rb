# Load the normal Rails helper
require File.expand_path(File.dirname(__FILE__) + '/../../../../test/test_helper')

# Ensure that we are using the temporary fixture path
Engines::Testing.set_fixture_path

require "webrat"

Webrat.configure do |config|
  config.mode = :rails
end

class Test::Unit::TestCase
  def setup
    setup_anonymous_role
    setup_non_member_role
  end
  
  def setup_anonymous_role
    begin
      @anon_role = Role.anonymous
    rescue
      @anon_role = Role.generate!
      @anon_role.update_attribute(:builtin, Role::BUILTIN_ANONYMOUS)
    end
  end

  def setup_non_member_role
    begin
      @anon_role = Role.non_member
    rescue
      @non_member_role = Role.generate!
      @non_member_role.update_attribute(:builtin, Role::BUILTIN_NON_MEMBER)
    end
  end

  def self.should_be_unauthorized(description, &block)
    context description do
      should "render the unauthorized template" do
        instance_eval &block
        assert_template 'common/403'
      end
      
      should "respond with unauthorized" do
        instance_eval &block
        assert_response 403
      end

    end
  end

end
