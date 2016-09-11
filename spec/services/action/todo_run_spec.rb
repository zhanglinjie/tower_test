require "rails_helper"
describe Action::TodoRun do
  let(:member){ create :member }
  let(:team){ Action::TeamCreation.new(name: generate(:name), creator: member).perform! }
  let(:project){ Action::ProjectCreation.new(name: generate(:name), creator: member, team: team).perform! }
  let(:todo){ Action::TodoCreation.new(name: generate(:name), creator: member, project: project).perform! }

  describe "run" do
    it "should change state to running" do
      expect {
        Action::TodoRun.new(todo: todo, actor: member).perform
      }.to change(Event::TodoRun, :count).by(1)
      todo.state.should == "running"
      todo.assignee.should == member
    end
  end
end