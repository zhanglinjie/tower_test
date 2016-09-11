module UrlService
  class << self
    include Rails.application.routes.url_helpers
  end

  def self.commentable_path(commentable, options={})
    case commentable.class.name
    when "Todo", "Message"
      polymorphic_path([commentable.project, commentable], options)
    when "CalendarEvent"
      polymorphic_path([commentable.team, commentable], options)
    else
    end
  end

  def self.event_ansector_path(ansector)
    case ansector.class.name
    when "Project", "Team"
      polymorphic_path([ansector])
    else
    end
  end

  def self.event_source_path(source, options={})
    case source.class.name
    when "Project"
      polymorphic_path([source], options)
    when "CalendarEvent"
      polymorphic_path([source.team, source], options)
    when "Todo", "Message"
      polymorphic_path([source.project, source], options)
    when "Comment"
      commentable_path(source.commentable, options.merge(anchor: source.id))
    else
    end
  end
end