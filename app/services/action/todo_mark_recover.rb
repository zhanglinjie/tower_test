class Action
  class TodoMarkRecover < Action::TodoBase
    perform do
      transaction do
        todo.mark_recover!
        todo.restore
        todo.update(assignee: nil)
        Event::TodoMarkRecover.create!(source: todo, actor: actor)
        todo
      end
    end
  end
end
