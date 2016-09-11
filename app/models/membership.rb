class Membership < ApplicationModel
  belongs_to :team
  belongs_to :member
  belongs_to :subgroup
  enum role: { staff: 0, admin: 1, visitor: 2, super_admin: 3 }
  validates_presence_of :team_id, :member_id, :role
end