class TasksController < ApplicationController
  authorize_resource

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find params[:id]
    @albums = @task.albums
    @comments = @task.comments.lasts
    @attachments = @task.attachments
    @new_comment = @task.comments.build
  end

  def create
    if params[:sku].present?
      @album = Album.where(sku: params[:sku]).first
    elsif params[:id].present?
      @album = Album.find params[:id]
    end

    if @album.present?
      @task = current_user.tasks.tmp_task.first
      ta = @task.task_albums.build album_id: @album.id
      if ta.save
        render layout: false
      else
        render text: '相册已加入任务中', status: 400
      end
    else
      render text: '找不到相册', status: 400
    end
  end

  def tmp
    @task = current_user.tasks.tmp_task.first
    if @task.blank?
      @task = current_user.tasks.new
      @task.save!(validate: false)
    end
    render layout: false
  end

  def publish
    @task = current_user.tasks.tmp_task.first
    if request.method == 'POST'
      if @task.update_attributes tmp_task_params.merge!({published_at: Time.now})
        render text: '发布成功', status: 200
      else
        render text: @task.errors.full_messages.join('.'), status: 400
      end
    else
      if @task.present?
        render layout: false
      else
        render text: '任务尚未创建，请先选择相册以建立任务', status: 400
      end
    end
  end

  def remove_album
    @task = Task.find params[:task_id]
    task_albums = @task.task_albums.where(album_id: params[:album_id])
    if task_albums.destroy_all
      render json: {tid: @task.id, aid: params[:album_id]}
    else
      render text: '删除失败', status: 400
    end
  end

  def new_attach
    @task = Task.find params[:id]
    @attachment = Attachment.new
    render layout: false
  end

  def create_attach
    @task = Task.find params[:id]
    @attachment = @task.attachments.build attach_params
    @attachment.user = current_user
    if @attachment.save
      redirect_to @task
    else
      redirect_to @task
    end
  end

  def add_pic
    begin
      @task = Task.find params[:id]
      @album = @task.albums.find params[:aid]
      @picture = @album.pictures.find params[:pid]

      task_album = @task.task_albums.where(album_id: @album.id).first
      if task_album
        pids = task_album.parsed_pic_ids
        pids.add @picture.id
        task_album.update_attribute :pic_ids, YAML.dump(pids.to_a)
      else
        raise ActiveRecord::RecordNotFound
      end
      render text: '添加成功'
    rescue ActiveRecord::RecordNotFound => e
      render text: "找不到对应的记录，请将一下信息发送给相关人员：<br/> #{e.message}", status: 404
    rescue Exception => e
      render text: e.message, status: 500
    end
  end

  def list_pic
    @task_album = TaskAlbum.where(task_id: params[:id], album_id: params[:aid]).first
    if @task_album.present?
      @pictures = Picture.find @task_album.parsed_pic_ids.to_a
      render layout: false
    else
      render text: '找不到对应记录', status: 400
    end
  end


  private
  def tmp_task_params
    params.require(:task).permit(:for_id, :id, :title)
  end


  def attach_params
    params.require(:attachment).permit(:file, :desc)
  end
end
