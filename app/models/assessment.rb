class Assessment < ActiveRecord::Base
  has_many :sections, :dependent => :destroy
  has_many :results, :as => :resultable
  accepts_nested_attributes_for :sections, :allow_destroy => true
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

  def self.search(search)
    if search
      where("title LIKE :search OR description LIKE :search", { :search => "%#{search}%" })
    else
      scoped
    end
  end
end
