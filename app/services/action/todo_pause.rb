class Action
  class TodoPause < Action::TodoBase
    perform do
      transaction do
        todo.pause!
        Event::TodoPause.create!(source: todo, actor: actor)
        todo
      end
    end
  end
end
