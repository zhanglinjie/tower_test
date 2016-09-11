class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_name %>, only: [:show, :edit, :update, :destroy]
  def index
    @q = <%= class_name%>.ransack(params[:q])
    @<%= plural_name %> = @q.result(distinct: true).paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.json{ render json: @<%= plural_name%>.map(&:as_select)}
    end
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @<%= singular_name %> = <%= class_name%>.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @<%= singular_name %> = <%= class_name%>.new(<%= singular_name %>_params)
    if @<%= singular_name %>.save
      respond_to do |format|
        format.html { redirect_to [@<%= singular_name %>], notice: "创建成功" }
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
    if @<%= singular_name %>.update(<%= singular_name %>_params)
      respond_to do |format|
        format.html { redirect_to [@<%= singular_name %>], notice: "更新成功" }
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    @<%= singular_name %>.destroy
    respond_to do |format|
      format.html { redirect_to <%= plural_name %>_path, notice: "删除成功" }
      format.js
    end
  end

  private
  def set_<%= singular_name %>
    @<%= singular_name %> = <%= class_name%>.find(params[:id])
  end

  def <%= singular_name %>_params
    <%- if attributes_names.empty? -%>
    params.fetch(:<%= singular_name %>, {})
    <%- else -%>
    params.require(:<%= singular_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
    <%- end -%>
  end
end