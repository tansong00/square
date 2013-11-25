class CommentsController < ApplicationController
  authorize_resource

  def create
    klass = params[:type].capitalize.constantize
    instance = klass.find params[:id]
    if instance.respond_to? :comments
      @comment = instance.comments.build comment_params
      @comment.user = current_user
      if @comment.save
      end
    end
    redirect_to self.send("#{params[:type]}_url", instance)
  end


  def owns
    @comments = current_user.comments.lasts.page(params[:page]).per(4)
    render layout: false
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
