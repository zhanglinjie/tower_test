class Event
  class TodoCreation < Event::TodoBase
    def action_desc
      "创建了任务"
    end
  end
end