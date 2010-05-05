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

          private

          # Override acts_as_list to allow nil priorities
          def add_to_list_bottom
            self
          end
        end
      end

      module ClassMethods
        def reprioritize(order)
          return nil unless order.present?
          ordered_ids = order.collect(&:to_i)
          
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
        
      end

      module InstanceMethods
      end
    end
  end
end
