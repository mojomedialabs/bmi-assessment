class UsersController < ApplicationController
  before_filter :ensure_login

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user

    params[:user][:privilege_level] = @user.privilege_level

    if @user.update_attributes(params[:user])
      flash[:type] = "success"

      flash[:notice] = t "flash.user.success.updated_self", :undo_link => undo_link

      redirect_to user_url(@user) and return
    else
      flash[:type] = "error"

      flash[:notice] = validation_errors_for(@user)

      render :action => :edit and return
    end
  end
end