class UploadsController < ApplicationController
  before_filter :require_admin

  def create
    @upload = Upload.new(params[:upload])
    if @upload.save
      flash[:notice] = 'Attachment was successfully added.'
      redirect_to(@upload.project)
    else
      flash[:error] = 'Can`t add attachment.'
      redirect_to :back
    end
  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy
    respond_to do |format|
      flash[:notice] = 'Attachment deleted'
      format.html { redirect_to :back }
      format.json { render :json => {:added => false} }
    end
  end
end
