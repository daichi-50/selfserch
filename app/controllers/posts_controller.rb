class PostsController < ApplicationController
    before_action :set_post, only: [ :edit, :update, :destroy]

    def index
        @posts = Post.page(params[:page])
    end

    def show
        @post = Post.find(params[:id])
        @message = Message.new
        @messages = @post.messages.includes(:user).order(created_at: :desc)
    end

    def new
        @post = current_user.posts.build
    end

    def create
        @post = current_user.posts.build(post_params)

        @post.set_prize_money #懸賞金の設定
        @post.create_image #画像の作成

        if @post.save
            flash[:success] = "Post created"
            redirect_to posts_path
        else
            render 'new'
        end
    end

    def edit; end

    def update
        if @post.update(post_params)
            flash[:success] = "Post updated"
            redirect_to posts_path
        else
            render 'edit'
        end
    end

    def destroy
        @post.destroy
        flash[:success] = "Post deleted"
        redirect_to posts_path
    end

private
    def post_params
        params.require(:post).permit(:image, :title, :prize_money, :description, :image_data_url)
    end

    def set_post
        @post = current_user.posts.find(params[:id])
    end
end
