class CommentsController < ApplicationController
  before_action :find_commentable, only: [:create]
  before_action :set_comment, except: [:create]
  before_action :authenticate_user!

  def create
    #creating new child object for commentable
    @comment = @commentable.comments.build(comment_params)
    #we can assign to current_user as we authenticate above: before_action :authenticate_user!
    @comment.user = current_user
    @comment.reply = true if params[:comment_id]
    @comment.save
  end

  def edit
  end

  def update
    if @comment.edit_history == ""
      #body - comment model has_rich_text :body
      @comment.edit_history = "Original " + @comment.body.body.to_plain_text + "\n"
    else
      @comment.edit_history = @comment.edit_history + "Edit: " + params[:comment][:body] + "\n"
    end
  @comment.update(comment_params)
  end

  def destroy
    @comment.destroy
  end

  def history
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    #comment - commenting on the comment
    if params[:comment_id]
      #commentable used ony inside create action
      @commentable = Comment.find_by_id(params[:comment_id])
    elsif params[:post_id]
      @commentable = Post.find_by_id(params[:post_id])
    end
    #post - commenting on the post
  end

  def set_comment
    @comment = comment.find(params[:id])
  end
end
