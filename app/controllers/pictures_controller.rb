class PicturesController < ApplicationController

  def upload
    @album = Album.find params[:album_id]
    @picture = @album.pictures.create! file: params[:files][0]
    @album.update_attribute(:cover, @picture.file) if @album.cover.blank?
    render json: {files: [@picture.to_jq_upload]}, status: :created
  end
end
