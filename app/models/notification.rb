class Notification < ActiveRecord::Base
  include Initiable

  ACTIONS = Activity::ACTIONS

  belongs_to :recipient, class_name: :User
  belongs_to :initiator, class_name: :User

  belongs_to :resource, -> { unscope where: :deleted }, polymorphic: true

  default_scope -> { where(resource_type: [Answer, Comment, Evaluation, Favorite, Labeling, Question]) }

  scope :for, lambda { |user| where(recipient: user) }
  scope :by,  lambda { |user| where(initiator: user) }

  scope :read,   lambda { unscope(where: :unread).where(unread: false) }
  scope :unread, lambda { unscope(where: :unread).where(unread: true) }

  symbolize :action, in: ACTIONS

  def read=(value)
    self.unread = !value
  end

  def read
    !self.unread
  end

  alias :read? :read

  def mark_as_read
    update unread: false, read_at: Time.now
  end

  def mark_as_unread
    update unread: true, read_at: nil
  end
end
