require "rails_helper"
describe Action::TodoMarkDeleted do
  let(:member){ create :member }
  let(:team){ Action::TeamCreation.new(name: generate(:name), creator: member).perform! }
  let(:project){ Action::ProjectCreation.new(name: generate(:name), creator: member, team: team).perform! }
  let(:todo){ Action::TodoCreation.new(name: generate(:name), creator: member, project: project).perform! }

  describe "mark deleted" do
    it "should change state to deleted" do
      expect {
        Action::TodoMarkDeleted.new(todo: todo, actor: member).perform
      }.to change(Event::TodoMarkDeleted, :count).by(1)
      todo.state.should == "deleted"
      todo.deleted_at.should be_present
    end
  end
end