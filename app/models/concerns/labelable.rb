module Labelable
  extend ActiveSupport::Concern

  included do
    has_many :labelings, dependent: :destroy
    has_many :labels, through: :labelings

    scope :labeled,   lambda { joins(:labelings) }
    scope :unlabeled, lambda { includes(:labelings).where(labelings: { answer_id: nil }) }

    scope :labeled_with, lambda { |label| joins(:labelings).merge(Labeling.with label) }
  end

  def labeled_by?(user, label)
    labelings.by(user).with(label).any?
  end

  def toggle_labeling_by!(user, label)
    label = Label.where(value: label).first_or_create! unless label.is_a? Label

    Labeling.deleted_or_new(author: user, answer: self, label: label).toggle_deleted_by! user
  end
end
