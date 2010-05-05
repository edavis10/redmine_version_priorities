class VersionPrioritiesController < ApplicationController
  unloadable
  helper :projects

  before_filter :require_admin, :only => :update

  def show
    @prioritized_versions = Version.visible.prioritized
    @unprioritized_versions = Version.visible.unprioritized
  end

  def update
    Version.reprioritize(params[:version])
    
    @prioritized_versions = Version.visible.prioritized
    @unprioritized_versions = Version.visible.unprioritized

    respond_to do |format|
      format.html { redirect_to version_priorities_path }
      format.js {
        render :partial => 'prioritized_versions', :layout => false
      }
    end
  end
end
