class AttachmentsController < ApplicationController
  before_action :require_login

  def destroy
    if current_user.root?
      @attachment = Attachment.find params[:id]
      @attachment.destroy
    else
      @attachment = current_user.attachments.find params[:id]
      @attachment.destroy
    end
  end

  def download
    @attachment = Attachment.find params[:id]
    send_file @attachment.file.file.path
  end

  private
  def attach_params
    params.require(:attachment).permit(:file, :desc)
  end
end
