class Access < ApplicationModel
  belongs_to :team
  belongs_to :accessable, polymorphic: true
  belongs_to :member
  validates_presence_of :team_id, :member_id, :accessable_id, :accessable_type
  set_from :accessable, targets: [:team_id]
end