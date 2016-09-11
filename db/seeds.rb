if Rails.env.development? && Member.count == 0
  ActiveRecord::Base.transaction do
    member_a = Member.create!(email: "member_a@test.com", nickname: "member_a", password: "123456")
    member_b = Member.create!(email: "member_b@test.com", nickname: "member_b", password: "123456")
    team = Action::TeamCreation.new(creator: member_a, name: "team").perform!
    project_a = Action::ProjectCreation.new(name: "project_a", team: team, creator: member_a).perform!
    project_b = Action::ProjectCreation.new(name: "project_b", team: team, creator: member_a).perform!
    Action::TeamJoinMember.new(team: team, member: member_b, role: :admin, project_ids: [project_a.id, project_b.id]).perform!
    todo_a = Action::TodoCreation.new(name: "todo_a", project: project_a, creator: member_a).perform!
    todo_b = Action::TodoCreation.new(name: "todo_b", project: project_b, creator: member_b).perform!
    Action::TodoRun.new(todo: todo_a, actor: member_a).perform!
    Action::TodoPause.new(todo: todo_a, actor: member_a).perform!
    Action::TodoComplete.new(todo: todo_a, actor: member_a).perform!
    Action::TodoReopen.new(todo: todo_a, actor: member_a).perform!
    Action::TodoMarkDeleted.new(todo: todo_a, actor: member_a).perform!
    Action::TodoMarkRecover.new(todo: todo_a, actor: member_a).perform!
    Action::TodoUpdation.new(todo: todo_a, actor: member_a, assignee_id: member_b.id).perform!
    Action::TodoUpdation.new(todo: todo_a, actor: member_a, assignee_id: member_a.id).perform!
    Action::TodoUpdation.new(todo: todo_a, actor: member_a, assignee_id: nil).perform!
    Action::TodoUpdation.new(todo: todo_a, actor: member_a, due_at: 1.day.since).perform!
    Action::TodoUpdation.new(todo: todo_a, actor: member_a, due_at: 2.day.since).perform!
    Action::TodoUpdation.new(todo: todo_a, actor: member_a, due_at: nil).perform!
    1.upto(20) do |index|
      Action::CommentCreation.new(content: "content_a_a_#{index}", author: member_a, commentable: todo_a).perform!
      Action::CommentCreation.new(content: "content_a_b_#{index}", author: member_a, commentable: todo_b).perform!
      Action::CommentCreation.new(content: "content_b_a_#{index}", author: member_b, commentable: todo_a).perform!
      Action::CommentCreation.new(content: "content_b_b_#{index}", author: member_b, commentable: todo_b).perform!
    end
  end
end