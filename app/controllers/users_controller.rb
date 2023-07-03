class UsersController < ApplicationController
    def index
        @users = User.order(money: :desc).limit(9)
    end

    def show
        @user = User.find(params[:id])
        @posts = @user.posts.page(params[:page]).per(3).order(created_at: :desc)

        @favorites = Favorite.where(user_id: @user.id).page(params[:page]).per(3).order(created_at: :desc)
    end

    def search
        @post = Post.find(params[:post_id])
        @users = User.where('username LIKE ?', "%#{params[:username]}%")
    end
end
