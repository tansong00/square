class AlbumsController < ApplicationController
  before_action :set_album, only: %i{edit update show}

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
  end

  def update

  end

  def show
    @pictures = @album.pictures
  end

  private
  def album_params
    params.require(:album).permit(:title, :sku, :cover)
  end

  def set_album
    @album = Album.find params[:id]
  end
end
