class AlbumsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
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
    @attachment = Attachment.new
    render layout: false
  end

  def create_attach
    @attachment = @album.attachments.build attach_params
    @attachment.user = current_user
    if @attachment.save
      redirect_to @album
    else
      redirect_to @album
    end
  end

  def authorize
    if request.method == 'POST'
      @user = User.find params[:authorize_user_id]
      if params[:all]
        @user.add_role :designer, Album
      else
        @user.add_role :designer, @album
      end
      render text: "[#{@user.username}] 授权成功"
    else
      @users = User.where.not(id: current_user.id)
      render layout: false
    end
  end

  private
  def album_params
    params.require(:album).permit(:title, :sku, :cover)
  end

  def attach_params
    params.require(:attachment).permit(:file, :desc)
  end
end
