class Admin::SurveysController < Admin::AdminController
helper_method :sort_column, :sort_order

  def index
    @surveys = Survey.search(params[:search]).page(params[:page]).order(sort_column + " " + sort_order)
  end

  def show
    @survey = Survey.find_by_slug(params[:id])

    if @survey.nil?
      flash[:type] = "error"

      flash[:notice] = t "flash.survey.error.could_not_find"

      redirect_to admin_surveys_url and return
    end
  end

  def new
    @survey = Survey.new

    1.times do
      section = @survey.sections.build

      3.times do
        question = section.questions.build

        4.times do
          question.answers.build
        end
      end
    end
  end

  def create
    @survey = Survey.new(params[:survey])

    unless @survey.nil?
      if @survey.save
        flash[:type] = "success"

        flash[:notice] = t "flash.survey.success.created", :survey_title => @survey.title, :undo_link => undo_link

        redirect_to admin_surveys_url and return
      else
        flash[:type] = "error"

        flash[:notice] = validation_errors_for(@survey)

        render :action => :new and return
      end
    else
      flash[:type] = "error"

      flash[:notice] = t "flash.survey.error.could_not_create"

      redirect_to new_admin_survey_url and return
    end
  end

  def edit
    @survey = Survey.find_by_slug(params[:id])

    if @survey.nil?
      flash[:type] = "error"

      flash[:notice] = t "flash.survey.error.could_not_find"

      redirect_to admin_surveys_url and return
    end
  end

  def update
    @survey = Survey.find_by_slug(params[:id])

    unless @survey.nil?
      if @survey.update_attributes(params[:survey])
        flash[:type] = "success"

        flash[:notice] = t "flash.survey.success.updated", :survey_title => @survey.title, :undo_link => undo_link

        redirect_to admin_survey_url(@survey) and return
      else
        flash[:type] = "error"

        flash[:notice] = validation_errors_for(@post)

        render :action => :edit and return
      end
    else
      flash[:type] = "error"

      flash[:notice] = t "flash.survey.error.could_not_find"

      redirect_to admin_surveys_url and return
    end
  end

  def destroy
    @survey = Survey.find_by_slug(params[:id])

    unless @survey.nil?
      @survey.destroy

      flash[:type] = "success"

      flash[:notice] = t "flash.survey.success.destroyed", :survey_title => @survey.title, :undo_link => undo_link

      redirect_to admin_survey_url and return
    else
      flash[:type] = "error"

      flash[:notice] = t "flash.survey.error.could_not_find"

      redirect_to admin_surveys_url and return
    end
  end

  private

  def sort_column
    Survey.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_order
    ["asc", "desc"].include?(params[:order]) ? params[:order] : "asc"
  end

  def undo_link
    view_context.link_to(t("flash.versions.undo"), revert_version_path(@survey.versions.scoped.last), :method => :post)
  end
end
