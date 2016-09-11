class Action
  class TodoBase < Action
    attr_accessor :actor, :todo
    validates_presence_of :actor, :todo
  end
end
