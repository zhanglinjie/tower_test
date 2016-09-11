class Calendar < ApplicationModel
  include Accessable
  include Caleventable
  include EventAncestor
  belongs_to :team
  belongs_to :creator, class_name: "Member"
  validates_presence_of :name, :team_id, :creator_id, :color
end