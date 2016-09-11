class Event
  class CommentBase < Event
    belongs_to :commentable, polymorphic: true
    delegate :name, to: :commentable, prefix: true
    alias_method :comment, :source
    set_from :source, targets: [:team_id, :commentable, commentable_ancestor: :ancestor, content: :comment_content]
  end
end