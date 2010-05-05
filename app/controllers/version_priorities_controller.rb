class VersionPrioritiesController < ApplicationController
  unloadable
  helper :projects

  before_filter :require_admin, :only => :update

  def show
    @prioritized_versions = Version.visible.all(:conditions => ["priority != 0 AND priority IS NOT NULL"], :order => 'priority ASC')
    @unprioritized_versions = Version.visible.all(:conditions => ["priority = 0 OR priority IS NULL"])
  end

  def update
    Version.reprioritize(params[:version]) if params[:version]
    
    @prioritized_versions = Version.visible.all(:conditions => ["priority != 0 AND priority IS NOT NULL"], :order => 'priority ASC')
    @unprioritized_versions = Version.visible.all(:conditions => ["priority = 0 OR priority IS NULL"])

    respond_to do |format|
      format.html { redirect_to version_priorities_path }
      format.js {
        render :partial => 'prioritized_versions', :layout => false
      }
    end
  end
end
