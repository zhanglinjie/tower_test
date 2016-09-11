class Event
  class TodoBase < Event
    alias_method :todo, :source
    set_from :source, targets: [:team_id, project: :ancestor]
  end
end