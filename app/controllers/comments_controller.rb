class CommentsController < ApplicationController
  before_action :set_post, only: %i[new create]

  def create
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user
    if @comment.content.blank?
      render "posts/show"
    elsif @comment.save
      redirect_to post_path(@comment.post), notice: "Votre commentaire a bien été publié"
    else
      render "posts/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
