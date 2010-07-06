class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  activate_js_erb_auto_include

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  before_filter :authenticate_user!, :prepare_vars
  layout :get_layout

  def prepare_vars
    @all_projects = current_user.is_admin? ? Project.all : current_user.projects if user_signed_in?
  end

  def get_layout
    ['sessions', 'registrations', 'passwords', 'confirmations'].include?(params[:controller]) ? 'sessions' : 'application'
  end

  def require_admin
    if current_user.nil?
      access_denied
    else
      return true if current_user.has_role?('admin')
      access_denied
    end
  end

  def access_denied
    flash[:error] = 'Access denied'
    redirect_to :back
  end
end
