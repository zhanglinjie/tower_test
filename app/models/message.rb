class Message < ApplicationModel
  include Commentable
  include EventSource
  belongs_to :team
  belongs_to :project
  belongs_to :creator, class_name: "Member"
  validates_presence_of :name, :team_id, :project_id
  alias_method :ancestor, :project
end