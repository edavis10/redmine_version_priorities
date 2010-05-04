class AddPriorityToVersions < ActiveRecord::Migration
  def self.up
    add_column :versions, :priority, :integer, :default => nil, :null => true
    add_index :versions, :priority
  end

  def self.down
    remove_index :versions, :priority
    remove_column :versions, :priority
  end
end
