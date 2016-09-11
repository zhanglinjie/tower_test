require 'rails_helper'

describe TeamsController do
  let(:member)   { create :member }
  let(:team) { Action::TeamCreation.new(creator: member, name: generate(:name)).perform! }
  let(:common_params) { {} }
  let(:valid_attributes) { attributes_for(:team, name: generate(:name)) }
  let(:invalid_attributes) { attributes_for(:team, name: nil) }

  before(:each) { sign_in member }

  describe "GET index" do
    it "assigns all teams as @teams" do
      team
      get :index, common_params
      assigns(:teams).should == [team]
    end
  end

  describe "GET show" do
    it "assigns the requested team as @team" do
      team
      get :show, { id: team.to_param}.merge(common_params)
      assigns(:team).should == team
    end
  end

  describe "GET new" do
    it "assigns a new team as @team" do
      get :new, common_params
      assigns(:team_creation).should be_a(Action::TeamCreation)
    end
  end

  describe "GET edit" do
    it "assigns the requested team as @team" do
      team
      get :edit, { id: team.to_param}.merge(common_params)
      assigns(:team).should == team
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "create succeed" do
        expect {
          post :create, { team: valid_attributes}.merge(common_params)
        }.to change(Team, :count).by(1)
        assigns(:team).errors.should be_empty
        assigns(:team).should be_a(Team)
        assigns(:team).should be_persisted
        response.should redirect_to([Team.last])
      end
    end

    describe "with invalid params" do
      it "create failed " do
        post :create, { team: invalid_attributes}.merge(common_params)
        assigns(:team_creation).errors.should be_present
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        attributes_for(:team, name: "new_name")
      }

      it "update succeed" do
        team
        put :update, { id: team.to_param, team: new_attributes}.merge(common_params)
        team.reload
        team.name.should == "new_name"
        assigns(:team).should == team
        response.should redirect_to([team])
      end
    end

    describe "with invalid params" do
      it "update failed" do
        team
        put :update, { id: team.to_param, team: invalid_attributes}.merge(common_params)
        assigns(:team).should == team
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested team" do
      team
      expect {
        delete :destroy, { id: team.to_param}.merge(common_params)
      }.to change(Team, :count).by(-1)
      response.should redirect_to([:teams])
    end
  end

end
