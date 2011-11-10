class PagesController < ApplicationController
  def index
    unless @current_user
      render :login
    end
  end

  def show
    @page = Page.find_by_slug(params[:id])
  end
end
