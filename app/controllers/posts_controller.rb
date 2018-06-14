class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :check_ownership, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.order('created_at desc').page params[:page]
    @posts_count = current_user.posts.length
  end
  
  def show
    @shows = Post.order('created_at desc').page params[:page]
    if user_signed_in?
      redirect_to posts_path
    end
  end
  
  def new
  end
  
  def create
    new_post = Post.new(user_id: current_user.id, content: params[:content], image: params[:image])
    if new_post.save
      redirect_to root_path
    else
      redirect_to new_post_path
    end
  end
  
  def edit
  end
  
  def update
    @post.content = params[:content]
    @post.image   = params[:image] if params[:image].present?
    
    if @post.save
      redirect_to root_path
    else
      render :edit
    end
  end
  
  def destroy
  
    @post.destroy
    redirect_to root_path
  end
  
  def mypage
      @mypages = Post.where(user_id: current_user.id).order('created_at desc')
      @mypage_count = current_user.posts.length
      @follows = Post.where(user_id: current_user.followings.ids).order('created_at desc')
      
  end
  
  private
  
  def check_ownership
    @post = Post.find_by(id: params[:id])
    redirect_to root_path if @post.user_id != current_user.id
  end
  
    
  
end
