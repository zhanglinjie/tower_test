require "rails_helper"
describe Action::TodoPause do
  let(:member){ create :member }
  let(:team){ Action::TeamCreation.new(name: generate(:name), creator: member).perform! }
  let(:project){ Action::ProjectCreation.new(name: generate(:name), creator: member, team: team).perform! }
  let(:todo){ Action::TodoCreation.new(name: generate(:name), creator: member, project: project).perform! }

  before(:each) do
    Action::TodoRun.new(todo: todo, actor: member).perform!
  end

  describe "pause" do
    it "should change state to pending" do
      expect {
        Action::TodoPause.new(todo: todo, actor: member).perform
      }.to change(Event::TodoPause, :count).by(1)
      todo.state.should == "pending"
    end
  end
end