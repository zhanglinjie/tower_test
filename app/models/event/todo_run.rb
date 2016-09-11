class Event
  class TodoRun < Event::TodoBase
    def action_desc
      "开始处理这条任务"
    end
  end
end