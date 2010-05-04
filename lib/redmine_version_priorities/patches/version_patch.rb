module RedmineVersionPriorities
  module Patches
    module VersionPatch
      def self.included(base)
        base.extend(ClassMethods)

        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable
          acts_as_list :column => 'priority'

          private

          # Override acts_as_list to allow nil priorities
          def add_to_list_bottom
            self
          end
        end
      end

      module ClassMethods
      end

      module InstanceMethods
      end
    end
  end
end
