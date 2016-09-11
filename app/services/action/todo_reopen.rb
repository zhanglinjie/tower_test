class Action
  class TodoReopen < Action::TodoBase
    perform do
      transaction do
        todo.reopen!
        Event::TodoReopen.create!(source: todo, actor: actor)
        todo
      end
    end
  end
end
