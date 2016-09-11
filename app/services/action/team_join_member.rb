class Action
  class TeamJoinMember < Action
    attr_accessor :team, :member, :role, :subgroup_id, :project_ids, :calendar_ids
    validates_presence_of :team, :member, :role
    perform do
      membership = Membership.create!(team: team, member: member, role: role, subgroup: subgroup)
      accessables.each do |accessable|
        Access.create!(accessable: accessable, member: member)
      end
      Event::TeamJoinMember.create!(source: team, actor: member)
      membership
    end

    private
    def subgroup
      @subgroup ||= team.subgroups.where(id: subgroup_id).first
    end

    def projects
      @projects ||= team.projects.where(id: project_ids)
    end

    def calendars
      @calendar ||= team.calendars.where(id: calendar_ids)
    end

    def accessables
      @accessables ||= [projects.to_a, calendars.to_a].flatten
    end
  end
end
