class PostsController < ApplicationController
    before_action :set_post, only: [:destroy, :favorites]
    skip_before_action :authenticate_user!, only: [:index, :show]

    def index
        @q = Post.ransack(params[:q])
        @posts = @q.result(distinct: true).page(params[:page]).includes(:user).order(created_at: :desc)
    end

    def show
        @post = Post.find(params[:id])
        @message = Message.new
        @messages = @post.messages.includes(:user)
    end

    def new
        @post = current_user.posts.build
    end

    def create
        @post = current_user.posts.build(post_params)

        if @post.valid? 
            @post.set_prize_money #懸賞金の設定
            @post.create_image #画像の作成
            if @post.save
                redirect_to posts_path, flash: { success: t('.success') }
            else
                flash.now[:error] = t('.error')
                render 'new'
            end
        else
            flash.now[:error] = t('.error')
            render 'new'
        end
    end

    def destroy
        @post.destroy
        redirect_to posts_path, flash: { success: t('.success') }
    end

private
    def post_params
        params.require(:post).permit(:image, :title, :prize_money, :description, :image_data_url)
    end

    def set_post
        @post = current_user.posts.find(params[:id])
    end
end
