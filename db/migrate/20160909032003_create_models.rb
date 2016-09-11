class CreateModels < ActiveRecord::Migration
  def change
    create_table :teams, id: :uuid do |t|
      t.string :name
      t.integer :projects_count
      t.references :creator, type: :uuid, index: true
      t.timestamps null: false
    end

    create_table :subgroups, id: :uuid do |t|
      t.references :team, type: :uuid, index: true
      t.references :creator, type: :uuid, index: true
      t.string :name
      t.timestamps null: false
    end

    create_table :memberships do |t|
      t.references :team, type: :uuid, index: true
      t.references :member, type: :uuid, index: true
      t.references :subgroup, type: :uuid, index: true
      t.integer :role #  0,1,2,3 成员 管理员 访客 超级管理员
      t.timestamps null: false
    end

    create_table :accesses do |t|
      t.references :team, type: :uuid, index: true
      t.references :accessable, type: :uuid, polymorphic: true, index: true
      t.references :member, type: :uuid, index: true
      t.timestamps null: false
    end

    create_table :projects, id: :uuid do |t|
      t.references :team, type: :uuid,  index: true
      t.references :creator, type: :uuid, index: true
      t.string :name
      t.text :desc
      t.timestamps null: false
    end

    create_table :todos, id: :uuid do |t|
      t.references :team, type: :uuid, index: true
      t.references :project, type: :uuid, index: true
      t.references :todo_list, type: :uuid, index: true
      t.references :creator, type: :uuid, index: true
      t.references :assignee, type: :uuid, index: true
      t.string :name
      t.text :desc
      t.datetime :due_at
      t.json :subtodos, array: true
      t.string :state
      t.datetime :deleted_at
      t.timestamps null: false
    end

    create_table :todo_lists, id: :uuid do |t|
      t.references :team, type: :uuid, index: true
      t.references :project, type: :uuid, index: true
      t.references :creator, type: :uuid, index: true
      t.string :name
      t.text :desc
      t.boolean :archived, default: false
      t.boolean :uncategorized, default: false
      t.timestamps null: false
    end

    create_table :calendars, id: :uuid do |t|
      t.references :team, type: :uuid, index: true
      t.references :creator, type: :uuid, index: true
      t.string :name
      t.integer :color # 1-18
      t.timestamps null: false
    end

    create_table :calendar_events, id: :uuid do |t|
      t.references :team, type: :uuid, index: true
      t.references :caleventable, type: :uuid, index: true, polymorphic: true
      t.references :creator, type: :uuid, index: true
      t.boolean :all_day, default: true
      t.string :name
      t.datetime :starts_at
      t.datetime :ends_at
      t.timestamps null: false
    end

    create_table :messages, id: :uuid do |t|
      t.references :team, type: :uuid, index: true
      t.references :project, type: :uuid, index: true
      t.references :creator, type: :uuid, index: true
      t.string :name
      t.text :desc
      t.timestamps null: false
    end

    create_table :comments, id: :uuid do |t|
      t.references :team, type: :uuid, index: true
      t.references :commentable, type: :uuid, polymorphic: true, index: true
      t.references :author, type: :uuid, index: true
      t.text :content
      t.datetime :deleted_at
      t.timestamps null: false
    end

    enable_extension 'hstore'
    create_table :events do |t|
      t.references :team, type: :uuid, index: true
      t.references :ancestor, type: :uuid, polymorphic: true, index: true
      t.references :source, type: :uuid, polymorphic: true, index: true
      t.references :commentable, type: :uuid, polymorphic: true, index: true
      t.references :actor, type: :uuid, index: true
      t.string :type
      t.hstore :data, default: {}, null: false
      t.timestamps null: false
    end
  end
end
