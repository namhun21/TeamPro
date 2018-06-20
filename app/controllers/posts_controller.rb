class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show] #사용자가 로그인한 사용자만 접근 가능하도록 하기위해
  before_action :check_ownership, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.order('created_at desc').page params[:page]
    @posts_count = current_user.posts.length #현재 유저가 작성한 글의 수
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
    new_post = Post.new(user_id: current_user.id, content: params[:content], image: params[:image]) #로그인한 유저의 아이디와 내용은 파라미터로 온 것을 저장
    if new_post.save #데이터베이스에 저장이 성공하면 루트로 이동
      redirect_to root_path 
    else  #실패하면 다시 작성하도록
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
