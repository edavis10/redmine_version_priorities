module RedmineVersionPriorities
  module Patches
    module VersionPatch
      def self.included(base)
        base.extend(ClassMethods)

        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable
          acts_as_list :column => 'priority'

          named_scope :prioritized, :conditions => ["priority != 0 AND priority IS NOT NULL"], :order => 'priority ASC'
          named_scope :unprioritized, :conditions => ["priority = 0 OR priority IS NULL"]

          named_scope :not_closed, :conditions => ["#{Version.table_name}.status != ?", 'closed']

          private

          # Override acts_as_list to allow nil priorities
          def add_to_list_bottom
            self
          end
        end
      end

      module ClassMethods
        def by_prioritized
          if priorities_restricted_by_view_issues?
            Version.visible.not_closed.prioritized
          else
            Version.not_closed.prioritized
          end
        end

        def by_unprioritized
          if priorities_restricted_by_view_issues?
            Version.visible.not_closed.unprioritized
          else
            Version.not_closed.unprioritized
          end
        end
        
        def reprioritize(order)
          ordered_ids = order.collect(&:to_i) if order.present?
          ordered_ids ||= []
          
          # Removed versions
          Version.visible.prioritized.each do |version|
            unless ordered_ids.include?(version.id)
              version.remove_from_list
            end
          end

          # Sort
          ordered_ids.each_with_index do |version_id, index|
            version = Version.find_by_id(version_id)
            version.insert_at( index + 1) if version
          end

        end

        def priorities_restricted_by_view_issues?
          return true unless Setting['plugin_redmine_version_priorities'].present?
          return true unless Setting['plugin_redmine_version_priorities']['restrictions'].present?
          
          return Setting['plugin_redmine_version_priorities']['restrictions'] == 'view_issues'
        end
      end

      module InstanceMethods
      end
    end
  end
end
