require 'rails_helper'

describe ProjectsController do
  let(:member)   { create :member }
  let(:team) { Action::TeamCreation.new(creator: member, name: generate(:name)).perform! }
  let(:project) { Action::ProjectCreation.new(team: team, creator: member, name: generate(:name)).perform! }
  let(:common_params) { { team_id: team.id } }
  let(:valid_attributes) { attributes_for(:project, name: generate(:name)) }
  let(:invalid_attributes) { attributes_for(:project, name: nil) }

  before(:each) { sign_in member }

  describe "GET index" do
    it "assigns all projects as @projects" do
      project
      get :index, common_params
      assigns(:projects).should == [project]
    end
  end

  describe "GET show" do
    it "assigns the requested project as @project" do
      project
      get :show, { id: project.to_param}.merge(common_params)
      assigns(:project).should == project
    end
  end

  describe "GET new" do
    it "assigns a new project as @project" do
      get :new, common_params
      assigns(:project_creation).should be_a(Action::ProjectCreation)
    end
  end

  describe "GET edit" do
    it "assigns the requested project as @project" do
      project
      get :edit, { id: project.to_param}.merge(common_params)
      assigns(:project).should == project
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "create succeed" do
        expect {
          post :create, { project: valid_attributes}.merge(common_params)
        }.to change(Project, :count).by(1)
        assigns(:project).errors.should be_empty
        assigns(:project).should be_a(Project)
        assigns(:project).should be_persisted
        response.should redirect_to([team, Project.last])
      end
    end

    describe "with invalid params" do
      it "create failed " do
        post :create, { project: invalid_attributes}.merge(common_params)
        assigns(:project_creation).errors.should be_present
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        attributes_for(:project, name: "new_name")
      }

      it "update succeed" do
        project
        put :update, { id: project.to_param, project: new_attributes}.merge(common_params)
        project.reload
        project.name.should == "new_name"
        assigns(:project).should == project
        response.should redirect_to([team, project])
      end
    end

    describe "with invalid params" do
      it "update failed" do
        project
        put :update, { id: project.to_param, project: invalid_attributes}.merge(common_params)
        assigns(:project).should == project
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested project" do
      project
      expect {
        delete :destroy, { id: project.to_param}.merge(common_params)
      }.to change(Project, :count).by(-1)
      response.should redirect_to([team, :projects])
    end
  end

end
