class Event
  class TodoReopen < Event::TodoBase
    def action_desc
      "重新打开了任务"
    end
  end
end