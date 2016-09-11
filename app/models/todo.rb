class Todo < ApplicationModel
  include Commentable
  include EventSource
  acts_as_paranoid
  belongs_to :team
  belongs_to :project
  belongs_to :todo_list
  belongs_to :creator, class_name: "Member"
  belongs_to :assignee, class_name: "Member"
  delegate :name, to: :assignee, prefix: true, allow_nil: true
  alias_method :ancestor, :project

  validates_presence_of :team_id, :project_id, :creator_id, :todo_list_id, :name
  set_from :todo_list, targets: [:project_id, :team_id], update_for_change: true

  acts_as_type :state, {
    pending:    "待处理",
    running:    "正在处理",
    completed:  "已完成",
    deleted:    "已删除"
  }
  state_machine :state, initial: :pending do
    event :run do
      transition :pending => :running
    end
    event :pause do
      transition :running => :pending
    end
    event :complete do
      transition [:pending, :running] => :completed
    end
    event :reopen do
      transition :completed => :pending
    end
    event :mark_recover do
      transition :deleted => :pending
    end
    event :mark_deleted do
      transition all - :deleted => :deleted
    end

    state :pending, :running do
      def active?
        true
      end
    end

    state :completed, :deleted do
      def active?
        false
      end
    end
  end
end