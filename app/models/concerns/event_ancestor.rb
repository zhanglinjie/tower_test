module EventAncestor
  extend ActiveSupport::Concern
  included do
    has_many :events, as: :ancestor
  end
end