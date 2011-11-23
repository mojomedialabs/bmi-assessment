class Section < ActiveRecord::Base
  belongs_to :assessment
  has_many :questions, :dependent => :destroy
  has_many :results, :as => :resultable, :dependent => :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :results, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  has_paper_trail

  after_initialize :initialize_defaults

  validates :title,
    :presence => true,
    :uniqueness => true

  validates :display_order,
    :presence => true,
    :numericality => true

  def initialize_defaults
    self.display_order ||= 0
  end

  def started?(user)
    self.questions.each do |question|
      if question.answered?(user)
        return true
      end
    end

    return true
  end

  def complete?(user)
    self.questions.each do |question|
      if !question.answered?(user)
        return false
      end
    end

    return true
  end

  def score(user)
    if !self.complete?(user)
      return 0
    end

    self.questions.inject(0) { |sum, question| sum + question.response_weight(user) }
  end

  def self.search(search)
    if search
      where("title LIKE :search OR description LIKE :search", { :search => "%#{search}%" })
    else
      scoped
    end
  end
end
