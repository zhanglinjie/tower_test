class Project::TodosController < ApplicationController
  before_action :set_project
  before_action :set_todo, except: [:index, :new, :create]
  def index
    @q = @project.todos.with_deleted.ransack(params[:q])
    @todos = @q.result.paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.json{ render json: @todos.map(&:as_select)}
    end
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @todo_creation = Action::TodoCreation.new(project: @project, creator: current_member)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @todo_creation = Action::TodoCreation.new(todo_creation_params.merge(project: @project, creator: current_member))
    @todo = @todo_creation.perform
    if @todo.present?
      respond_to do |format|
        format.html { redirect_to [@project, @todo], notice: "创建成功" }
        format.js
      end
    else
      render :new
    end
  end

  def edit
    todo_options = @todo.as_json(only: [:name, :desc, :assignee_id, :due_at])
    @todo_updation = Action::TodoUpdation.new(todo_options.merge(todo: @todo, actor: current_member))
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @todo_updation = Action::TodoUpdation.new(todo_updation_params.merge(todo: @todo, actor: current_member))
    if @todo_updation.perform
      respond_to do |format|
        format.html { redirect_to [@project, @todo], notice: "更新成功" }
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    Action::TodoMarkDeleted.new(todo: @todo, actor: current_member).perform!
    respond_to do |format|
      format.html { redirect_to [@project, :todos], notice: "删除成功" }
      format.js{ render :update }
    end
  end

  def recover
    Action::TodoMarkRecover.new(todo: @todo, actor: current_member).perform!
    respond_to do |format|
      format.html { redirect_to [@project, @todo], notice: "恢复成功" }
      format.js{ render :update }
    end
  end

  def run
    Action::TodoRun.new(todo: @todo, actor: current_member).perform!
    respond_to do |format|
      format.html { redirect_to [@project, @todo], notice: "任务进行中" }
      format.js{ render :update }
    end
  end

  def pause
    Action::TodoPause.new(todo: @todo, actor: current_member).perform!
    respond_to do |format|
      format.html { redirect_to [@project, @todo], notice: "任务暂停" }
      format.js{ render :update }
    end
  end

  def complete
    Action::TodoComplete.new(todo: @todo, actor: current_member).perform!
    respond_to do |format|
      format.html { redirect_to [@project, @todo], notice: "任务完成" }
      format.js{ render :update }
    end
  end

  def reopen
    Action::TodoReopen.new(todo: @todo, actor: current_member).perform!
    respond_to do |format|
      format.html { redirect_to [@project, @todo], notice: "任务重开" }
      format.js{ render :update }
    end
  end

  private
  def set_project
    @project = current_team.projects.access_by(current_member).find(params[:project_id])
    add_breadcrumb "项目", [@project.team, :projects]
    add_breadcrumb @project.name, [@project]
    add_breadcrumb "任务清单", [@project, :todos]
  end

  def set_todo
    @todo = @project.todos.with_deleted.find(params[:id])
    add_breadcrumb @todo.name, [@project, @todo]
  end

  def todo_creation_params
    params.require(:todo).permit(:name, :desc)
  end

  def todo_updation_params
    params.require(:todo).permit(:assignee_id, :due_at, :name, :desc)
  end
end