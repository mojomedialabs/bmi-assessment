class AssessmentsController < ApplicationController
  #layout 'assessments'

  before_filter :ensure_login

  def index
    @assessments = Assessment.all
  end

  def show
    @assessment = Assessment.find_by_slug(params[:id])
  end
end