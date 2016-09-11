require "rails_helper"
describe Action::TeamCreation do
  let(:member){ create :member }

  describe "perform with valid data" do
    it "should create team" do
      team_creation = Action::TeamCreation.new(name: generate(:name), creator: member)
      expect {
        team = team_creation.perform
        team.should be_a(Team)
        member.teams.should == [team]
      }.to change(Event::TeamCreation, :count).by(1)
    end
  end
end