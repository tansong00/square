class AlbumsController < ApplicationController
  def index

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

  end

  private
  def album_params
    params.require(:album).permit(:title, :sku)
  end
end
