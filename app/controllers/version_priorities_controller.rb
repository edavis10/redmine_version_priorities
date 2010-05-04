class VersionPrioritiesController < ApplicationController
  unloadable
  helper :projects

  def show
    @prioritized_versions = Version.visible.all(:conditions => ["priority != 0 AND priority IS NOT NULL"], :order => 'priority ASC')
    @unprioritized_versions = Version.visible.all(:conditions => ["priority = 0 OR priority IS NULL"])
  end
end
