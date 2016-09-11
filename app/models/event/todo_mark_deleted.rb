class Event
  class TodoMarkDeleted < Event::TodoBase
    def action_desc
      "删除了任务"
    end
  end
end