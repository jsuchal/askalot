class Favorite < ActiveRecord::Base
  include Deletable
  include Notifiable

  belongs_to :favorer, class_name: :User, counter_cache: true
  belongs_to :question, counter_cache: true

  scope :by, lambda { |user| where(favorer: user) }

  def to_question
    self.question
  end
end
