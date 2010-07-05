class VersionPrioritiesController < ApplicationController
  unloadable
  helper :projects

  before_filter :require_admin, :only => :update

  def show
    @prioritized_versions = Version.by_prioritized
    @unprioritized_versions = Version.by_unprioritized
  end

  def update
    Version.reprioritize(params[:version])
    
    @prioritized_versions = Version.by_prioritized
    @unprioritized_versions = Version.by_unprioritized

    respond_to do |format|
      format.html { redirect_to version_priorities_path }
      format.js {
        render :partial => 'prioritized_versions', :layout => false
      }
    end
  end
end
