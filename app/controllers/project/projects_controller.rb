class Project::ProjectsController < ApplicationController
  before_action :set_project
  def show
    respond_to do |format|
      format.html
    end
  end

  private
  def set_project
    @project = current_team.projects.access_by(current_member).find(params[:id])
    add_breadcrumb "项目", [@project.team, :projects]
    add_breadcrumb @project.name, [@project]
  end
end
