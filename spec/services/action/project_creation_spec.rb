require "rails_helper"
describe Action::ProjectCreation do
  let(:member){ create :member }
  let(:team){ Action::TeamCreation.new(name: generate(:name), creator: member).perform! }
  let(:project){ Action::ProjectCreation.new(name: generate(:name), creator: member, team: team).perform! }

  describe "perform with valid data" do
    it "should create project" do
      project_creation = Action::ProjectCreation.new(name: generate(:name), creator: member, team: team)
      expect {
        project = project_creation.perform
        project.should be_a(Project)
        project.accessors.should == [member]
      }.to change(Event::ProjectCreation, :count).by(1)
    end

    it "should create uncategorized todo_list" do
      project_creation = Action::ProjectCreation.new(name: generate(:name), creator: member, team: team)
      expect {
        project = project_creation.perform
      }.to change(TodoList, :count).by(1)
      project.uncategorized_todo_list.should be_present
    end
  end
end