require 'rails_helper'

describe Project::TodosController do
  let(:member)   { create :member }
  let(:team) { Action::TeamCreation.new(creator: member, name: generate(:name)).perform! }
  let(:project) { Action::ProjectCreation.new(team: team, creator: member, name: generate(:name)).perform! }
  let(:todo) { Action::TodoCreation.new(project: project, creator: member, name: generate(:name)).perform! }
  let(:common_params) { { project_id: project.id } }
  let(:valid_attributes) { attributes_for(:todo, name: generate(:name)) }
  let(:invalid_attributes) { attributes_for(:todo, name: nil) }

  before(:each) {
    session[:current_team_id] = team.id
    sign_in member
  }

  describe "GET index" do
    it "assigns all todos as @todos" do
      todo
      get :index, common_params
      assigns(:todos).should == [todo]
    end
  end

  describe "GET show" do
    it "assigns the requested todo as @todo" do
      todo
      get :show, { id: todo.to_param}.merge(common_params)
      assigns(:todo).should == todo
    end
  end

  describe "GET new" do
    it "assigns a new todo as @todo" do
      get :new, common_params
      assigns(:todo_creation).should be_a(Action::TodoCreation)
    end
  end

  describe "GET edit" do
    it "assigns the requested todo as @todo" do
      todo
      get :edit, { id: todo.to_param}.merge(common_params)
      assigns(:todo_updation).should be_a(Action::TodoUpdation)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "create succeed" do
        expect {
          post :create, { todo: valid_attributes}.merge(common_params)
        }.to change(Todo, :count).by(1)
        assigns(:todo).errors.should be_empty
        assigns(:todo).should be_a(Todo)
        assigns(:todo).should be_persisted
        response.should redirect_to([project, Todo.last])
      end
    end

    describe "with invalid params" do
      it "create failed " do
        post :create, { todo: invalid_attributes}.merge(common_params)
        assigns(:todo_creation).should be_a(Action::TodoCreation)
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        attributes_for(:todo, name: "new_name")
      }

      it "update succeed" do
        todo
        put :update, { id: todo.to_param, todo: new_attributes}.merge(common_params)
        todo.reload
        todo.name.should == "new_name"
        assigns(:todo).should == todo
        response.should redirect_to([project, todo])
      end
    end

    describe "with invalid params" do
      it "update failed" do
        todo
        put :update, { id: todo.to_param, todo: invalid_attributes}.merge(common_params)
        assigns(:todo_updation).errors.should be_present
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested todo" do
      todo
      expect {
        delete :destroy, { id: todo.to_param}.merge(common_params)
      }.to change(Todo, :count).by(-1)
      response.should redirect_to([project, :todos])
    end
  end

end
