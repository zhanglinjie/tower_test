class Event
  class TodoChangeAssignee < Event::TodoBase
    data_references :previous_assignee, class_name: "Member"
    data_references :after_assignee, class_name: "Member"
    delegate :name, to: :previous_assignee, prefix: true, allow_nil: true
    delegate :name, to: :after_assignee, prefix: true, allow_nil: true

    def action_desc
      if previous_assignee.blank?
        "给 #{after_assignee_name} 指派了任务"
      elsif after_assignee.blank?
        "取消了 #{previous_assignee_name} 的任务"
      else
        "将任务完成者从 #{previous_assignee_name} 修改为 #{after_assignee_name}"
      end
    end
  end
end