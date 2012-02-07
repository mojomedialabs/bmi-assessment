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

  def answered?(user)
    self.answers.each do |answer|
      response = Response.find_by_user_id_and_answer_id(user.id, answer.id)

      if !response.nil?
        return true
      end
    end

    return false
  end

  def response_weight(user)
    self.answers.each do |answer|
      response = Response.find_by_user_id_and_answer_id(user.id, answer.id)

      if !response.nil?
        return answer.weight
      end
    end

    return nil
  end

  def min_score
    min = nil

    self.answers.each do |answer|
      if !min.nil? and answer.weight < min
        min = answer.weight
      elsif min.nil?
        min = answer.weight
      end
    end

    unless min.nil?
      return min
    else
      return 0
    end
  end

  def max_score
    max = nil

    self.answers.each do |answer|
      if !max.nil? and answer.weight > max
        max = answer.weight
      elsif max.nil?
        max = answer.weight
      end
    end

    unless max.nil?
      return max
    else
      return 0
    end
  end

  def self.search(search)
    if search
      where("content LIKE :search", { :search => "%#{search}%" })
    else
      scoped
    end
  end
end
