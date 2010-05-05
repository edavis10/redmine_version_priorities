require 'redmine'

Redmine::Plugin.register :redmine_version_priorities do
  name 'Version Priorities'
  url 'https://projects.littlestreamsoftware.com/projects/redmine-kanban'
  author_url 'http://www.littlestreamsoftware.com'
  description 'Allows versions to be prioritized'
  version '0.1.'

  requires_redmine :version_or_higher => '0.9.0'

  menu(:top_menu,
       :version_priorities,
       {:controller => 'version_priorities', :action => 'show'},
       :caption => :version_priorities_title,
       :if => Proc.new {
         User.current.logged?
       })

  permission(:view_version_priorities, {:version_priorities => [:show]}, :public => true)

end

require 'dispatcher'
Dispatcher.to_prepare :redmine_version_priorities do

  require_dependency 'issue'
  Issue.send(:include, RedmineVersionPriorities::Patches::IssuePatch)

  require_dependency 'query'
  unless Query.included_modules.include?(RedmineVersionPriorities::Patches::QueryPatch)
    Query.send(:include, RedmineVersionPriorities::Patches::QueryPatch)
  end

  require_dependency 'version'
  Version.send(:include, RedmineVersionPriorities::Patches::VersionPatch)
end
