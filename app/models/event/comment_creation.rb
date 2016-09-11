class Event
  class CommentCreation < Event::CommentBase
    data_attr :comment_content, :string
    def action_desc
      "回复了#{I18n.t("activerecord.models.#{commentable_type.underscore}")}"
    end
  end
end