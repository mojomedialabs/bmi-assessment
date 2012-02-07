class PagesController < ApplicationController
  def index
    unless @current_user
      render :login
    end

    @assessments = Assessment.all
  end

  def show
    @page = Page.find_by_slug(params[:id])

    if @page.nil?
      flash[:type] = "error"

      flash[:notice] = t "flash.page.error.could_not_find"

      redirect_to root_url and return
    end
  end
end
