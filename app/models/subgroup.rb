class Subgroup < ApplicationModel
  belongs_to :team
  belongs_to :creator, class_name: "Member"
  has_many :memberships
  validates_presence_of :name, :team_id
end