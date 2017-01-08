class CommentsController < ApplicationController
    before_action :authenticate_user!
    
    def create
        @post = Post.find(params[:post_id])
        @comment = Comment.create(params[:comment].permit(:content))
        @comment.user_id = current_user.id
        @comment.post_id = @post.id
        
        
        respond_to do |format|
          if @comment.save
            format.html { redirect_to post_path(@post) }
            format.json { render :show, status: :created, location: @post }
          else
            flash[:danger] = 'يجب ملء حقل التعليق'
            format.html { redirect_to post_path(@post) }
            format.json { render json: @comment.errors, status: :unprocessable_entity }
          end
        end
    end
    
    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post)
    end
end
