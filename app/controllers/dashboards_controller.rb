class DashboardsController < ApplicationController
  def index
  end

  def search
    case params[:type]
      when 'sku'
        @albums = Album.where(sku: params[:kw])
      else
        redirect_to root_url and return
    end
    album_ids = @albums.map(&:id)
    @tasks = Task.actives.where(id: TaskAlbum.where(album_id: album_ids).pluck(:task_id))
    @attachments = Attachment.where(attachmentable_id: album_ids, attachmentable_type: 'Album')
  end
end
