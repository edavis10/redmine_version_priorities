module RedmineVersionPriorities
  module Patches
    module QueryPatch
      def self.included(base)
        base.extend(ClassMethods)

        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable

          add_available_column(QueryColumn.new(:fixed_version_priority,
                                               :sortable => ["#{Version.table_name}.priority IS NULL",
                                                             "#{Version.table_name}.priority",
                                                             "#{Version.table_name}.effective_date",
                                                             "#{Version.table_name}.name"],
                                               :default_order => 'asc'))
                                               
        end
      end

      module ClassMethods
        # Setter for +available_columns+ that isn't provided by the core.
        def available_columns=(v)
          self.available_columns = (v)
        end

        # Method to add a column to the +available_columns+ that isn't provided by the core.
        def add_available_column(column)
          self.available_columns << (column)
        end
      end

      module InstanceMethods
      end
    end
  end
end
