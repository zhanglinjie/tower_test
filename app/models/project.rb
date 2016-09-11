class Project < ApplicationModel
  include Accessable
  include Caleventable
  include EventAncestor
  include EventSource
  belongs_to :team, counter_cache: true
  belongs_to :creator, class_name: "Member"
  has_many :todos
  has_many :todo_lists
  has_one :uncategorized_todo_list, -> { uncategorized }, class_name: "TodoList"
  validates_presence_of :name, :team_id
end