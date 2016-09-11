require "rails_helper"
describe Action::TodoMarkRecover do
  let(:member){ create :member }
  let(:team){ Action::TeamCreation.new(name: generate(:name), creator: member).perform! }
  let(:project){ Action::ProjectCreation.new(name: generate(:name), creator: member, team: team).perform! }
  let(:todo){ Action::TodoCreation.new(name: generate(:name), creator: member, project: project).perform! }

  before(:each) do
    Action::TodoMarkDeleted.new(todo: todo, actor: member).perform!
  end

  describe "mark recover" do
    it "should change state to pending" do
      expect {
        Action::TodoMarkRecover.new(todo: todo, actor: member).perform
      }.to change(Event::TodoMarkRecover, :count).by(1)
      todo.state.should == "pending"
      todo.assignee.should be_nil
    end
  end
end