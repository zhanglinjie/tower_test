require "rails_helper"
describe Action::TodoComplete do
  let(:member){ create :member }
  let(:team){ Action::TeamCreation.new(name: generate(:name), creator: member).perform! }
  let(:project){ Action::ProjectCreation.new(name: generate(:name), creator: member, team: team).perform! }
  let(:todo){ Action::TodoCreation.new(name: generate(:name), creator: member, project: project).perform! }

  describe "complete" do
    it "should change state to completed" do
      expect {
        Action::TodoComplete.new(todo: todo, actor: member).perform
      }.to change(Event::TodoComplete, :count).by(1)
      todo.state.should == "completed"
      todo.assignee.should == member
    end
  end
end