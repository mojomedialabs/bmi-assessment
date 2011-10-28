class Question < ActiveRecord::Base
  belongs_to :section
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  has_paper_trail

  after_initialize :initialize_defaults

  validates :display_order,
    :presence => true,
    :numericality => true

  def initialize_defaults
    self.display_order ||= 0
  end

  def self.search(search)
    if search
      where("content LIKE :search", { :search => "%#{search}%" })
    else
      scoped
    end
  end
end
