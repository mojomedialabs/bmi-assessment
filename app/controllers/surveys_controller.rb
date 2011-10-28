class SurveysController < ApplicationController
  layout 'assessments'

  before_filter :ensure_login

  def index
    @surveys = Survey.all
  end

  def show
    @survey = Survey.find_by_slud(params[:id])
  end
end