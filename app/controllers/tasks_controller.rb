class TasksController < ApplicationController
  before_action :require_login

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
    @task = current_user.tasks.create if @task.blank?
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


  private
  def tmp_task_params
    params.require(:task).permit(:for_id, :id, :title)
  end
end
