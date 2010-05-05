require File.dirname(__FILE__) + '/../../../../test_helper'

class RedmineVersionPriorities::Patches::QueryTest < ActionController::TestCase

  context "Query" do
    should 'have a fixed version priority column' do
      assert Query.available_columns.collect(&:name).include?(:fixed_version_priority), "Fixed version priority column not found"
    end

    should 'allow sorting on the fixed version priority column' do
      fixed_version_priority_column = Query.available_columns.select {|column| column.name == :fixed_version_priority}.first

      assert fixed_version_priority_column, "Fixed version priority column not found"
      assert fixed_version_priority_column.sortable?, "Column not sortable"
    end
  end
end
