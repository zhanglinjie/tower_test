class Team < ApplicationModel
  include EventAncestor
  include EventSource
  belongs_to :creator, class_name: "Member"
  has_many :projects
  has_many :calendars
  has_many :subgroups
  has_many :memberships
  has_many :members, through: :memberships
  has_many :events
  validates_presence_of :name
  delegate :name, to: :creator, prefix: true, allow_nil: true

end