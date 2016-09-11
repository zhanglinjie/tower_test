require "rails_helper"
describe Action::TodoUpdation do
  let(:member){ create :member }
  let(:team){ Action::TeamCreation.new(name: generate(:name), creator: member).perform! }
  let(:project){ Action::ProjectCreation.new(name: generate(:name), creator: member, team: team).perform! }
  let(:todo){ Action::TodoCreation.new(name: generate(:name), creator: member, project: project).perform! }

  before do
    todo
  end

  describe "update name" do
    it "should change name" do
      expect {
          Action::TodoUpdation.new(name: "new_name", actor: member, todo: todo).perform
        }.to change(Event, :count).by(0)
      todo.name.should == "new_name"
    end
  end

  describe "update assignee" do
    it "should create event of todo_change_assignee" do
      expect {
          Action::TodoUpdation.new(name: todo.name, assignee_id: member.id, actor: member, todo: todo).perform
        }.to change(Event::TodoChangeAssignee, :count).by(1)
    end
  end

  describe "update due_at" do
    it "should create event of todo_change_due_at" do
      expect {
          Action::TodoUpdation.new(name: todo.name, due_at: 3.days.since, actor: member, todo: todo).perform
        }.to change(Event::TodoChangeDueAt, :count).by(1)
    end
  end
end