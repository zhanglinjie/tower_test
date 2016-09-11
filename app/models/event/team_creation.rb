class Event
  class TeamCreation < Event::TeamBase
    def action_desc
      "创建了团队"
    end
  end
end