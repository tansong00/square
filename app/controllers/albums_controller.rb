class AlbumsController < ApplicationController
  before_action :set_album, only: %i{edit update show}
  before_action :require_root, only: [:new, :create, :edit, :update]

  def index
    @albums = Album.page params[:page]
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new album_params
    if @album.save
      redirect_to albums_url
    else
      render :new
    end
  end

  def edit
    render layout: false
  end

  def update
    if @album.update_attributes album_params

    end
    redirect_to album_url(@album)
  end

  def show
    @pictures = @album.pictures
    @comments = @album.comments.lasts
    @new_comment = @album.comments.build
    @tasks = @album.tasks.actives
    @attachments = @album.attachments
  end

  def new_attach
    @album = Album.find params[:id]
    @attachment = Attachment.new
    render layout: false
  end

  def create_attach
    @album = Album.find params[:id]
    @attachment = @album.attachments.build attach_params
    @attachment.user = current_user
    if @attachment.save
      redirect_to @album
    else
      redirect_to @album
    end
  end

  private
  def album_params
    params.require(:album).permit(:title, :sku, :cover)
  end

  def set_album
    @album = Album.find params[:id]
  end

  def attach_params
    params.require(:attachment).permit(:file, :desc)
  end
end
