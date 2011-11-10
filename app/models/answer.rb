class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :responses
  has_paper_trail

  after_initialize :initialize_defaults

  validates :weight,
    :presence => true,
    :numericality => true

  validates :display_order,
    :presence => true,
    :numericality => true

  def initialize_defaults
    self.weight ||= 1
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
