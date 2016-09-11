class Action
  class TodoUpdation < Action::TodoBase
    attr_accessor :assignee_id, :due_at, :name, :desc
    validates_presence_of :name

    def initialize(attributes={})
      super
      [:assignee_id, :due_at, :name, :desc].each do |key|
        self.send("#{key}=", attributes.fetch(key, todo.send(key)))
      end
    end

    perform do
      transaction do
        todo.assign_attributes(assignee_id: assignee_id, due_at: due_at, name: name, desc: desc)
        if todo.assignee_id_changed?
          Event::TodoChangeAssignee.create!(source: todo, actor: actor, previous_assignee_id: todo.assignee_id_was, after_assignee_id: todo.assignee_id)
        end
        if todo.due_at_changed?
          Event::TodoChangeDueAt.create!(source: todo, actor: actor, previous_due_at: todo.due_at_was, after_due_at: todo.due_at)
        end
        todo.save!
        todo
      end
    end
  end
end
