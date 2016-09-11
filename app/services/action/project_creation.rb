class Action
  class ProjectCreation < Action
    attr_accessor :name, :desc, :creator, :team
    validates_presence_of :name, :creator, :team
    perform do
      transaction do
        project = Project.create!(team: team, creator: creator, name: name, desc: desc)
        Access.create!(accessable: project, member: creator)
        project.todo_lists.create!(name: "未归类任务", creator: creator, uncategorized: true)
        Event::ProjectCreation.create!(source: project, actor: creator)
        project
      end
    end
  end
end
