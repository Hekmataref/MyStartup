class PostsController < ApplicationController
    before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote]
    before_action :authenticate_user!, except: [:index, :show, :most_liked]
    
    def index
        @posts = Post.all.order("created_at DESC")
    end
    
    def most_liked
        @most_liked = Post.all.order(cached_votes_score: :DESC)
    end
    
    def show
        @comments = Comment.where(post_id: @post)
        @random_post = Post.where.not(id: @post).order("RANDOM()").first
    end
    
    def new
        @post = current_user.posts.build
    end
    
    def create
        @post = current_user.posts.build(post_params)
        
        
        respond_to do |format|
            if @post.save
              flash[:success] = 'تمت إضافة المشروع بنجاح.'
              format.html { redirect_to @post }
              format.json { render :show, status: :created, location: @post }
            else
              flash[:danger] = 'هناك مشكلة عند إضافة المشروع.'
              format.html { render :new }
              format.json { render json: @post.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def edit
    end
    
    def update
        respond_to do |format|
            if @post.update(post_params)
              flash[:success] = 'تم تحديث المشروع بنجاح.'
              format.html { redirect_to @post }
              format.json { render :show, status: :ok, location: @post }
            else
              flash[:danger] = 'هناك مشكلة استكمال المشروع.'
              format.html { render :edit }
              format.json { render json: @post.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def destroy
        @post.destroy
        redirect_to root_path
    end
    
    def upvote
        @post.upvote_by current_user
        redirect_to :back
    end

    private
    
    def find_post
        @post = Post.find(params[:id])
    end
    
    def post_params
        params.require(:post).permit(:title, :link, :description, :image)
    end

end
