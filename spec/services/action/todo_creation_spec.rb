require "rails_helper"
describe Action::TodoCreation do
  let(:member){ create :member }
  let(:team){ Action::TeamCreation.new(name: generate(:name), creator: member).perform! }
  let(:project){ Action::ProjectCreation.new(name: generate(:name), creator: member, team: team).perform! }

  describe "perform with valid data" do
    it "should create todo" do
      todo_creation = Action::TodoCreation.new(name: generate(:name), creator: member, project: project)
      expect {
        todo = todo_creation.perform
        todo.should be_a(Todo)
        todo.todo_list.should == project.uncategorized_todo_list
      }.to change(Event::TodoCreation, :count).by(1)
    end
  end
end