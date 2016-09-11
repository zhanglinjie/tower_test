class Action
  class TodoMarkDeleted < Action::TodoBase
    perform do
      transaction do
        todo.mark_deleted!
        todo.destroy
        Event::TodoMarkDeleted.create!(source: todo, actor: actor)
        todo
      end
    end
  end
end
