class Tag < ActiveRecord::Base
  include Watchable

  has_many :taggings, dependent: :restrict_with_exception
  has_many :questions, through: :taggings
  has_many :answers, through: :questions

  scope :recent,  lambda { where('created_at >= ?', Time.now - 1.month ).unscope(:order).order(:created_at) }
  scope :popular, lambda { select('tags.*, count(*) as c').joins(:taggings).group('tags.id').unscope(:order).order('c desc').limit(30) }

  before_save :normalize

  def value
    read_attribute(:name)
  end

  def normalize
    self.name = name.to_s.downcase.gsub(/[^[:alnum:]]+/, '-').gsub(/\A-|-\z/, '')
  end

  def count
    questions.size
  end
end
