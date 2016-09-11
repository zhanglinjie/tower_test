class Event
  class TeamBase < Event
    set_from :source, targets: [{ id: :team_id, itself: :ancestor }]
  end
end