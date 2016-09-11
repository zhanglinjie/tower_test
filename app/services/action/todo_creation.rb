class Action
  class TodoCreation < Action
    attr_accessor :creator, :name, :desc, :project, :todo_list
    validates_presence_of :creator, :name, :project

    def initialize(attributes={})
      super
      @todo_list = @project.uncategorized_todo_list if @todo_list.blank?
    end

    perform do
      transaction do
        todo = Todo.create!(creator: creator, name: name, desc: desc, project: project, todo_list: todo_list)
        Event::TodoCreation.create!(source: todo, actor: creator)
        todo
      end
    end
  end
end
