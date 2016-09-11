class Action
  class TodoRun < Action::TodoBase
    perform do
      transaction do
        todo.run!
        todo.update(assignee: actor)
        Event::TodoRun.create!(source: todo, actor: actor)
        todo
      end
    end
  end
end
