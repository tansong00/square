class AttachmentsController < ApplicationController
  load_and_authorize_resource

  def destroy
    if current_user.root?
      @attachment.destroy
    else
      @attachment.destroy
    end
  end

  def download
    send_file @attachment.file.file.path
  end

  private
  def attach_params
    params.require(:attachment).permit(:file, :desc)
  end
end
