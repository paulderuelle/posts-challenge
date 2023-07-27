class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @posts = Post.all

    if params[:query].present?
      sql_subquery = <<~SQL
        title ILIKE :query
        OR content ILIKE :query
      SQL
      @posts = @posts.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post), notice: "Votre article a bien été publié"
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :url, :image)
  end
end
