class Event < ApplicationModel
  belongs_to :team
  belongs_to :ancestor, polymorphic: true
  belongs_to :source, polymorphic: true
  belongs_to :actor, class_name: "Member"
  validates_presence_of :team_id, :ancestor_id, :actor_id

  scope :by_project, ->(project_id){ where(ancestor_id: project_id, ancestor_type: "Project") if project_id.present? && project_id != -1 }
  scope :by_member, ->(member_id){ where(actor_id: member_id) if member_id.present? && member_id != -1 }
  scope :by_till_id, ->(till_id){ where("id < ?", till_id) if till_id.present? }

  default_scope ->{ order(id: :desc) }

  delegate :name, to: :team, prefix: true
  delegate :name, to: :ancestor, prefix: true
  delegate :name, to: :source, prefix: true
  delegate :name, to: :actor, prefix: true

  # hstore:data
  def self.data_attr(key, type, options={})
    key = key.to_s
    define_method key do
      case type
      when :date, :datetime
        data[key].try(:to_time)
      else
        data[key]
      end
    end

    define_method "#{key}=" do |value|
      case type
      when :string
        data[key] = value
      when :boolean
        data[key] = [true, "1", 1].include?(value)
      when :date
        data[key] = value
      else
        data[key] = value
      end
    end
  end

  def self.data_references(name, options={})
    name = name.to_s
    key = name.foreign_key
    class_name = options[:class_name] || name.classify
    klass = class_name.constantize

    define_method key do
      data.fetch(key, nil)
    end

    define_method "#{key}=" do |value|
      data[key] = value
    end

    define_method name do
      klass.find_by(id: self.send(key)) if self.send(key).present?
    end

    define_method "#{name}=" do |value|
      self.send("#{key}=", value.try(:id))
    end
  end

  def action_desc
    raise NotImplementedError
  end
end