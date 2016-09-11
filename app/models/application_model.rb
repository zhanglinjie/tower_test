class ApplicationModel < ActiveRecord::Base
  self.abstract_class = true
  def self.first
    order("created_at").first
  end

  def self.last
    order("created_at DESC").first
  end

  def as_select
    { id: id, name: name }
  end

  class << self
    alias_method :hname, :human_attribute_name
  end
end