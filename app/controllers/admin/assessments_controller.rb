class Admin::AssessmentsController < Admin::AdminController
  helper_method :sort_column, :sort_order

  def index
    @assessments = Assessment.search(params[:search]).page(params[:page]).order(sort_column + " " + sort_order)
  end

  def show
    @assessment = Assessment.find_by_slug(params[:id])

    if @assessment.nil?
      flash[:type] = "error"

      flash[:notice] = t "flash.assessment.error.could_not_find"

      redirect_to admin_assessments_url and return
    end
  end

  def new
    @assessment = Assessment.new
  end

  def create
    @assessment = Assessment.new(params[:assessment])

    unless @assessment.nil?
      if @assessment.save
        flash[:type] = "success"

        flash[:notice] = t "flash.assessment.success.created", :assessment_title => @assessment.title, :undo_link => undo_link

        redirect_to admin_assessments_url and return
      else
        flash[:type] = "error"

        flash[:notice] = validation_errors_for(@assessment)

        render :action => :new and return
      end
    else
      flash[:type] = "error"

      flash[:notice] = t "flash.assessment.error.could_not_create"

      redirect_to new_admin_assessment_url and return
    end
  end

  def edit
    @assessment = Assessment.find_by_slug(params[:id])

    if @assessment.nil?
      flash[:type] = "error"

      flash[:notice] = t "flash.assessment.error.could_not_find"

      redirect_to admin_assessments_url and return
    end
  end

  def update
    @assessment = Assessment.find_by_slug(params[:id])

    unless @assessment.nil?
      if @assessment.update_attributes(params[:assessment])
        flash[:type] = "success"

        flash[:notice] = t "flash.assessment.success.updated", :assessment_title => @assessment.title, :undo_link => undo_link

        redirect_to admin_assessment_url(@assessment) and return
      else
        flash[:type] = "error"

        flash[:notice] = validation_errors_for(@assessment)

        render :action => :edit and return
      end
    else
      flash[:type] = "error"

      flash[:notice] = t "flash.assessment.error.could_not_find"

      redirect_to admin_assessments_url and return
    end
  end

  def destroy
    @assessment = Assessment.find_by_slug(params[:id])

    unless @assessment.nil?
      @assessment.destroy

      flash[:type] = "success"

      flash[:notice] = t "flash.assessment.success.destroyed", :assessment_title => @assessment.title, :undo_link => undo_link

      redirect_to admin_assessment_url and return
    else
      flash[:type] = "error"

      flash[:notice] = t "flash.assessment.error.could_not_find"

      redirect_to admin_assessments_url and return
    end
  end

  private

  def sort_column
    Assessment.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_order
    ["asc", "desc"].include?(params[:order]) ? params[:order] : "asc"
  end

  def undo_link
    view_context.link_to(t("flash.versions.undo"), revert_version_path(@assessment.versions.scoped.last), :method => :post)
  end
end
