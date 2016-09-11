class Event
  class TodoComplete < Event::TodoBase
    def action_desc
      "完成了任务"
    end
  end
end