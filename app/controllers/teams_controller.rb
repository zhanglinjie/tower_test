class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  def index
    set_current_team(nil)
    @q = Team.ransack(params[:q])
    @teams = @q.result(distinct: true).paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.json{ render json: @teams.map(&:as_select)}
    end
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @team_creation = Action::TeamCreation.new(creator: current_member)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @team_creation = Action::TeamCreation.new(team_creation_params.merge(creator: current_member))
    @team = @team_creation.perform
    if @team.present?
      respond_to do |format|
        format.html { redirect_to [@team], notice: "创建成功" }
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
    if @team.update(team_updation_params)
      respond_to do |format|
        format.html { redirect_to [@team], notice: "更新成功" }
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_path, notice: "删除成功" }
      format.js
    end
  end

  private
  def set_team
    @team = Team.find(params[:id])
  end

  def team_creation_params
    params.require(:team).permit(:name)
  end

  def team_updation_params
    params.require(:team).permit(:name)
  end
end