class TodoList < ApplicationModel
  belongs_to :team
  belongs_to :project
  belongs_to :creator, class_name: "Member"
  validates_presence_of :name, :team_id, :project_id, :creator_id
  scope :uncategorized, ->{ where(uncategorized: true) }
  scope :categorized, ->{ where(uncategorized: false) }
  set_from :project, targets: [:team_id]
end