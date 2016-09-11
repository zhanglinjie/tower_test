class Action
  class CommentCreation < Action
    attr_accessor :content, :author, :commentable_id, :commentable_type, :commentable
    validates_presence_of :content, :author, :commentable
    def initialize(attributes={})
      super
      if commentable.blank? && commentable_type.present? && commentable_id.present?
        @commentable = commentable_type.constantize.find(commentable_id)
      end
    end

    perform do
      transaction do
        comment = Comment.create!(commentable: commentable, content: content, author: author)
        Event::CommentCreation.create!(source: comment, actor: author)
        comment
      end
    end
  end
end
