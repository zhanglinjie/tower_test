module Accessable
  extend ActiveSupport::Concern
  included do
    has_many :accesses, as: :accessable
    has_many :accessors, through: :accesses, source: :member
    scope :access_by, ->(member){ includes(:accesses).where(accesses: { member_id: member.try(:id) })}
  end
end