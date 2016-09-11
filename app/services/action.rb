class Action
  include ActiveModel::Model
  def perform
    raise NotImplementedError
  end

  def transaction
    ActiveRecord::Base.transaction do
      yield
    end
  end

  def self.perform(&block)
    define_method :perform do
      if valid?
        self.instance_exec(&block)
      else
        false
      end
    end
    define_method :perform! do
      if valid?
        self.instance_exec(&block)
      else
        raise Action::InvalidError.new(self)
      end
    end
  end

  class InvalidError < StandardError
    attr_accessor :action
    def initialize(action)
      @action = action
      super(action.errors.full_messages.join(","))
    end
  end
end
