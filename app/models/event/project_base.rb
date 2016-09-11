class Event
  class ProjectBase < Event
    alias_method :project, :source
    set_from :source, targets: [:team_id, itself: :ancestor]
  end
end