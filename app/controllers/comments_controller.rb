class CommentsController < ApplicationController
  before_action :require_login

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


  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
