module EventHelper
  def event_text(event)
    if event.is_a?(Event::CommentBase)
      link_to(event.commentable_name, UrlService.commentable_path(event.commentable))
    elsif event.is_a?(Event::TeamBase)
      event.team_name
    else
      link_to(event.source_name, UrlService.event_source_path(event.source))
    end
  end

  def event_body(event)
    if event.is_a?(Event::CommentBase)
      link_to(event.comment_content, UrlService.event_source_path(event.comment))
    else
    end
  end
end