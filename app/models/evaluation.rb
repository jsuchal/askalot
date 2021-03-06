class Evaluation < ActiveRecord::Base
  include Authorable
  include Deletable
  include Notifiable

  belongs_to :evaluable, polymorphic: true, counter_cache: true

  validates :value, presence: true, inclusion: { in: -2..2 }

  scope :by, lambda { |user| where(author: user) }

  before_save :normalize

  def normalize
    self.text = nil if text.blank?
  end

  def to_question
    self.evaluable.to_question
  end
end
