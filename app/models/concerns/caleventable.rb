module Caleventable
  extend ActiveSupport::Concern
  included do
    has_many :calendar_events, as: :caleventable
  end
end