class Result < ActiveRecord::Base
  belongs_to :resultable, :polymorphic => true
  has_paper_trail

  after_initialize :initialize_defaults

  validates :top,
    :presence => true,
    :numericality => true

  validates :bottom,
    :presence => true,
    :numericality => true

  validate :top_must_be_greater_than_bottom

  def initialize_defaults
    self.top ||= 1
    self.bottom ||= 0
  end

  def top_must_be_greater_than_bottom
    errors.add(:parent_id, I18n.t("activerecord.errors.models.result.top_and_bottom_order")) if bottom >= top
  end

  def self.search(search)
    if search
      where("title LIKE :content LIKE :search", { :search => "%#{search}%" })
    else
      scoped
    end
  end
end
