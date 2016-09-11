class CalendarEvent < ApplicationModel
  include Commentable
  include EventSource
  belongs_to :team
  belongs_to :caleventable, polymorphic: true
  alias_method :ancestor, :caleventable
  belongs_to :creator, class_name: "Member"
  validates_presence_of :name, :team_id, :caleventable_type, :caleventable_id, :creator_id
end