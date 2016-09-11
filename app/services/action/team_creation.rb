class Action
  class TeamCreation < Action
    attr_accessor :creator, :name
    validates_presence_of :creator, :name

    perform do
      transaction do
        team = Team.create!(name: name, creator: creator)
        Membership.create!(team: team, member: creator, role: :super_admin)
        Event::TeamCreation.create!(source: team, actor: creator)
        team
      end
    end
  end
end
