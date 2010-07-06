class TasksController < ApplicationController
  before_filter :require_admin, :except => [:show, :comment, :my_tasks]
  def show
    @task = Task.find(params[:id])
    @page_title = @task.project.title + ' > ' + @task.title
    @comment = Comment.new
    @comment.build_upload
    if current_user.is_admin? || @task.project.users.include?(current_user)
      respond_to do |format|
        format.html
      end
    else
      access_denied
    end
  end

  def new
    @task = Task.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        flash[:notice] = 'Task was successfully created.'
        format.html { redirect_to(@task.project) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'Task was successfully updated.'
        format.html { redirect_to(@task.project) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to(tasks_url) }
    end
  end
  
  def my_tasks
    @tasks = Task.all(:conditions => "user_id=#{current_user.id}")
  end

  def close
    task = Task.find(params[:id])
    task.close_task
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {:closed => true} }
    end
  end

  def open
    task = Task.find(params[:id])
    task.open_task
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :json => {:closed => false} }
    end
  end

  def comment
    @task = Task.find(params[:id])
    @comment = Comment.new params[:comment]
    @comment.upload = nil if @comment.upload.node_file_name.nil?
    @comment.user = current_user
    respond_to do |format|
      if @task.comments << @comment
        format.html do
          flash[:notice] = 'Comment added.'
          redirect_to :back
        end
        format.json { render :json => {:comment => @comment, :added => true} }
      else
        format.html do
          flash[:error] = 'Can`t add comment.'
          @comment.errors.each{|e| flash[:error] += "<br>" + e.join(' ')}
          redirect_to :back
        end
        format.json { render :json => {:errors => @comment.errors, :added => false} }
      end
    end
  end
end
