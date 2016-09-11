class Comment < ApplicationModel
  include EventSource
  acts_as_paranoid
  belongs_to :team
  belongs_to :commentable, polymorphic: true
  delegate :ancestor, to: :commentable, prefix: true
  belongs_to :author, class_name: "Member"
  delegate :name, to: :author, prefix: true, allow_nil: true
  validates_presence_of :team_id, :commentable_id, :commentable_type, :author_id, :content
  set_from :commentable, targets: [:team_id]
  default_scope ->{ order(created_at: :asc) }
end