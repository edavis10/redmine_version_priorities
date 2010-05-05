class VersionPrioritiesController < ApplicationController
  unloadable
  helper :projects

  before_filter :require_admin, :only => :update

  def show
    @prioritized_versions = Version.visible.all(:conditions => ["priority != 0 AND priority IS NOT NULL"], :order => 'priority ASC')
    @unprioritized_versions = Version.visible.all(:conditions => ["priority = 0 OR priority IS NULL"])
  end

  def update
    Version.visible.all(:conditions => ["priority != 0 AND priority IS NOT NULL"], :order => 'priority ASC').each do |version|
      unless params[:version] && params[:version].include?(version.id.to_s)
        version.remove_from_list
      end
    end
    
    params[:version].each_with_index do |version_id, index|
      version = Version.find_by_id(version_id)
      version.insert_at( index + 1) if version
    end if params[:version] && params[:version].present?
    
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
