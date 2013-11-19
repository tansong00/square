class AttachmentsController < ApplicationController
  before_action :require_login

  def new
    @attachment = Attachment.new
    render layout: false
  end

  def create
    klass = params[:type].capitalize.constantize
    instance = klass.find params[:id]
    if instance.respond_to? :attachments
      @attachment = instance.attachments.build attach_params
      @attachment.user = current_user
      if @attachment.save
      end
    end
    redirect_to self.send("#{params[:type]}_url", instance)
  end

  def destroy
    if current_user.root?
      @attachment = Attachment.find params[:id]
      @attachment.destroy
    else
      @attachment = current_user.attachments.find params[:id]
      @attachment.destroy
    end
  end


  private
  def attach_params
    params.require(:attachment).permit(:file, :desc)
  end
end
