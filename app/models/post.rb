class Post < ActiveRecord::Base
  belongs_to :user, :validate => true
  has_paper_trail
  paginates_per 10

  before_validation :generate_slug

  validates :title,
    :presence => true,
    :uniqueness => true

  validates :slug,
    :presence => true,
    :uniqueness => true

  validates :status,
    :presence => true,
    :numericality => true

  validate :user_must_exist

  def initialize_defaults
    self.status ||= 0
    self.private ||= false
  end

  def user_must_exist
    errors.add(:user_id, t("activerecord.errors.models.post.user_must_exist")) if user_id && user.nil?
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
      where("title LIKE :search OR body LIKE :search OR style LIKE :search", { :search => "%#{search}%" })
    else
      scoped
    end
  end
end
