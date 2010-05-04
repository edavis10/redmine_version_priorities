require 'redmine'

Redmine::Plugin.register :redmine_version_priorities do
  name 'Version Priorities'
  url 'https://projects.littlestreamsoftware.com/projects/redmine-kanban'
  author_url 'http://www.littlestreamsoftware.com'
  description 'Allows versions to be prioritized'
  version '0.1.'

  requires_redmine :version_or_higher => '0.9.0'
end

require 'dispatcher'
Dispatcher.to_prepare :redmine_version_priorities do

  require_dependency 'version'
  Version.send(:include, RedmineVersionPriorities::Patches::VersionPatch)
end
