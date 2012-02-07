class Admin::AdminController < ApplicationController
  layout :get_layout

  helper :all

  skip_before_filter :get_current_user

  before_filter :get_current_user, :is_facilitator?

  before_filter :is_sysop?, :only => :reboot

  def index
  end

  def reboot
    %x[touch "#{File.join(Rails.root, "tmp", "restart.txt")}"]

    flash[:type] = "information"

    flash[:notice] = t "flash.reboot"

    redirect_to admin_root_url and return
  end

  def get_layout
    "admin"
  end
end
