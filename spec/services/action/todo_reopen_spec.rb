require "rails_helper"
describe Action::TodoReopen do
  let(:member){ create :member }
  let(:team){ Action::TeamCreation.new(name: generate(:name), creator: member).perform! }
  let(:project){ Action::ProjectCreation.new(name: generate(:name), creator: member, team: team).perform! }
  let(:todo){ Action::TodoCreation.new(name: generate(:name), creator: member, project: project).perform! }

  before do
    Action::TodoComplete.new(todo: todo, actor: member).perform!
  end

  describe "reopen" do
    it "should change state to pending" do
      expect {
        Action::TodoReopen.new(todo: todo, actor: member).perform
      }.to change(Event::TodoReopen, :count).by(1)
      todo.state.should == "pending"
    end
  end
end