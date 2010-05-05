module RedmineVersionPriorities
  module Patches
    module IssuePatch
      def self.included(base)
        base.extend(ClassMethods)

        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable
        end
      end

      module ClassMethods
      end

      module InstanceMethods
        def fixed_version_priority
          if fixed_version && fixed_version.priority.present?
            fixed_version
          else
            l(:label_none)
          end
        end
      end
    end
  end
end
