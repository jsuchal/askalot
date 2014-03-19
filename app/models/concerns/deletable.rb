module Deletable
  extend ActiveSupport::Concern

  included do
    belongs_to :deletor, class_name: :User

    scope :deleted,   lambda { where(deleted: true) }
    scope :undeleted, lambda { where(deleted: false) }

    default_scope -> { undeleted }
  end

  def mark_as_deleted_by!(user, datetime = DateTime.now.in_time_zone)
    self.transaction(requires_new: true) do
      self.mark_as_deleted_recursive!(user, datetime)

      self.deleted    = true
      self.deletor    = user
      self.deleted_at = datetime

      decrement_counter = self.deleted_changed?

      self.save!

      if decrement_counter
        self.decrement_counter_caches!
      end
    end
  end

  protected

  def mark_as_deleted_recursive!(user, datetime)
    self.reflections.each do |key, target|
      if mark_as_deleted? target
        self.send(key.to_s).each do |child|
          child.mark_as_deleted_by!(user, datetime)
        end
      end
    end
  end

  def mark_as_deleted?(model)
    model.options[:dependent] == :destroy && model.macro == :has_many && model.klass.column_names.include?('deleted')
  end

  def decrement_counter_caches!
    self.reflections.each do |key, target|
      if target.macro == :belongs_to && target.options[:counter_cache] == true
        owner  = self.send(key.to_s)
        column = target.counter_cache_column.to_sym

        owner.class.decrement_counter(column, owner.id)
        owner.decrement column
      end
    end
  end
end
