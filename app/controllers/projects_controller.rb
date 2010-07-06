class ProjectsController < ApplicationController
  before_filter :require_admin, :except => [:index, :show, :tag]

  def index
    @projects = @all_projects
    respond_to do |format|
      format.html
    end
  end

  def show
    @project = Project.find(params[:id])
    @page_title = @project.title + ' > Tasks'
    @tasks = @project.tasks
    @tags = @tasks.tag_counts
    if current_user.can_view_project?  @project
      respond_to do |format|
        format.html
        format.js
      end
    else
      access_denied
    end
  end

  def tag
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks.find_tagged_with(params[:tag])
    @page_title = @project.title + ' > Tasks'
    @tags = @project.tasks.tag_counts
    if current_user.can_view_project?  @project
      respond_to do |format|
        format.html{ render :action => 'show' }
        format.js{ render :action => 'show' }
      end
    else
      access_denied
    end
  end

  def user
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks.assigned_to(params[:id])
    @page_title = @project.title + ' > Tasks'
    @tags = @project.tasks.tag_counts
    if current_user.can_view_project?  @project
      respond_to do |format|
        format.html{ render :action => 'show' }
        format.js{ render :action => 'show' }
      end
    else
      access_denied
    end
  end

  def new
    @project = Project.new
    @page_title = 'New project'
    respond_to do |format|
      format.html
    end
  end

  def edit
    @project = Project.find(params[:id])
    @page_title = @project.title + ' > Edit'
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @project = Project.new(params[:project])
    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to(@project) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @project = Project.find(params[:id])
    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.html { redirect_to(projects_url) }
    end
  end

  def add_user
    project = Project.find(params[:id])
    project.users << User.find(params[:user_id])
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {:added => true} }
    end
  end

  def remove_user
    project = Project.find(params[:id])
    project.users.delete(User.find(params[:user_id]))
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {:added => false} }
    end
  end

  def add_attachment
    project = Project.find(params[:id])
    @upload = Upload.new(params[:upload])
    respond_to do |format|
      if project.uploads << @upload
        flash[:notice] = 'Attachment added.'
        format.html { redirect_to project }
      else
        format.html do
          flash[:error] = 'Can`t add attachment.'
          @upload.errors.each{|e| flash[:error] += "<br>" + e.join(' ')}
          redirect_to project
        end
      end
    end
  end
end
