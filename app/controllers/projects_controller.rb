class ProjectsController < ApplicationController
  before_action :set_team
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  def index
    @q = current_team.projects.ransack(params[:q])
    @projects = @q.result(distinct: true).paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.json{ render json: @projects.map(&:as_select)}
    end
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @project_creation = Action::ProjectCreation.new(creator: current_member, team: current_team)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @project_creation = Action::ProjectCreation.new(project_creation_params.merge(creator: current_member, team: current_team))
    @project = @project_creation.perform
    if @project.present?
      respond_to do |format|
        format.html { redirect_to [current_team, @project], notice: "创建成功" }
        format.js
      end
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @project.update(project_params)
      respond_to do |format|
        format.html { redirect_to [current_team, @project], notice: "更新成功" }
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to [current_team, :projects], notice: "删除成功" }
      format.js
    end
  end

  private
  def set_team
    @team = current_member.teams.find(params[:team_id])
    set_current_team(@team)
  end

  def set_project
    @project = current_team.projects.find(params[:id])
  end

  def project_creation_params
    params.require(:project).permit(:name, :desc)
  end

  def project_params
    params.require(:project).permit(:name, :desc)
  end
end