class Section < ActiveRecord::Base
  belongs_to :survey
  has_many :questions, :dependent => :destroy
  has_many :results, :as => :resultable, :dependent => :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :results, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  has_paper_trail

  after_initialize :initialize_defaults
  before_validation :generate_slug

  validates :title,
    :presence => true,
    :uniqueness => true

  validates :display_order,
    :presence => true,
    :numericality => true

  def initialize_defaults
    self.display_order ||= 0
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

  def self.search(search)
    if search
      where("title LIKE :search OR description LIKE :search", { :search => "%#{search}%" })
    else
      scoped
    end
  end
end
