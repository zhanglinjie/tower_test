class Event
  class TodoPause < Event::TodoBase
    def action_desc
      "暂停处理这条任务"
    end
  end
end