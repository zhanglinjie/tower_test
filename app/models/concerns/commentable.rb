module Commentable
  extend ActiveSupport::Concern
  included do
    has_many :comments, as: :commentable

    def ancestor
      raise NotImplementedError
    end
  end
end