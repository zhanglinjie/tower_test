class Action
  class TodoComplete < Action::TodoBase
    perform do
      transaction do
        todo.complete!
        todo.update(assignee: actor)
        Event::TodoComplete.create!(source: todo, actor: actor)
        todo
      end
    end
  end
end
