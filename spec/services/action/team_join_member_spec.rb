require "rails_helper"
describe Action::TeamJoinMember do
  let(:member){ create :member }
  let(:another_member){ create :member }
  let(:team){ Action::TeamCreation.new(name: generate(:name), creator: member).perform! }
  let(:project){ Action::ProjectCreation.new(name: generate(:name), creator: member, team: team).perform! }

  describe "perform with valid data" do
    it "should create membership" do
      team_join_member = Action::TeamJoinMember.new(member: another_member, team: team, role: :staff, project_ids: [project.id])
      expect {
        membership = team_join_member.perform
        membership.should be_a(Membership)
        another_member.teams.should == [team]
        project.accessors.should be_include(another_member)
      }.to change(Event::TeamJoinMember, :count).by(1)
    end
  end
end