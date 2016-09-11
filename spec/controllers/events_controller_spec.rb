require 'rails_helper'

describe EventsController do
  let(:member)   { create :member }
  let(:team) { Action::TeamCreation.new(creator: member, name: generate(:name)).perform! }
  let(:project) { Action::ProjectCreation.new(team: team, creator: member, name: generate(:name)).perform! }
  let(:todo) { Action::TodoCreation.new(project: project, creator: member, name: generate(:name)).perform! }
  let(:comment) { Action::CommentCreation.new(content: generate(:content), author: member, commentable: todo).perform! }

  before(:each) {
    sign_in member
    comment
  }

  describe "GET index" do
    it "should render index" do
      get :index, team_id: team.id
      response.should render_template("index")
    end
  end

  describe "GET index xhr" do
    it "should render load_more" do
      xhr :get, :index, team_id: team.id
      response.should render_template("load_more")
    end
  end
end
