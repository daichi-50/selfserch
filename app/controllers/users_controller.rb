class UsersController < ApplicationController
    def index
        @users = User.order(money: :desc).limit(9)
    end

    def show
        @user = User.find(params[:id])
        @posts = @user.posts
    end

    def search
        @post = Post.find(params[:post_id])
        @users = User.where('username LIKE ?', "%#{params[:username]}%")
    end
end
