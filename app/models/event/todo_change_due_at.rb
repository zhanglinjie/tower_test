class Event
  class TodoChangeDueAt < Event::TodoBase
    data_attr :previous_due_at, :date
    data_attr :after_due_at, :date

    def action_desc
      "将任务完成时间从 #{format_due_at(previous_due_at)} 修改为 #{format_due_at(after_due_at)}"
    end

    private
    def format_due_at(time)
      time.present? ? time.strftime('%F') : "没有截止时间"
    end
  end
end