class Assessment < ActiveRecord::Base
  has_many :sections, :dependent => :destroy
  has_many :results, :as => :resultable, :dependent => :destroy
  accepts_nested_attributes_for :sections, :allow_destroy => true
  accepts_nested_attributes_for :results, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  has_paper_trail

  after_initialize :initialize_defaults
  before_validation :generate_slug

  validates :title,
    :presence => true,
    :uniqueness => true

  validates :slug,
    :presence => true,
    :uniqueness => true

  validates :display_order,
    :presence => true,
    :numericality => true

  validates :status,
    :presence => true,
    :numericality => true

  scope :published, lambda { where("assessments.published >= ?", 1) }

  def initialize_defaults
    self.display_order ||= 0
    self.status ||= 0
  end

  def to_param
    self.slug
  end

  def generate_slug
    if self.title.blank?
      self.slug = self.id
    else
      self.slug = self.title.parameterize
    end
  end

  def started?(user)
    if self.sections.length == 0
      return false
    end

    self.sections.each do |section|
      if section.started?(user)
        return true
      end
    end

    return false
  end

  def complete?(user)
    if self.sections.length == 0
      return false
    end

    self.sections.each do |section|
      if !section.complete?(user)
        return false
      end
    end

    return true
  end

  def score(user)
    if !self.complete?(user)
      return 0
    end

    self.sections.inject(0) { |sum, section| sum + section.score(user) }
  end

  def min_score
    min = 0

    self.sections.each do |section|
      min += section.min_score
    end

    min
  end

  def max_score
    max = 0

    self.sections.each do |section|
      max += section.max_score
    end

    return max
  end

  def time_started
    return Time.now
  end

  def time_finished
    return Time.now
  end

  def self.search(search)
    if search
      where("title LIKE :search OR description LIKE :search", { :search => "%#{search}%" })
    else
      scoped
    end
  end
end
