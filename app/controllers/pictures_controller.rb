class PicturesController < ApplicationController

  def upload
    @album = Album.find params[:album_id]
    @picture = @album.pictures.create! file: params[:files][0]
    render text: {msg: 'ok'}
  end
end
