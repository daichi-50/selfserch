class UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]

    def new
        @user = User.new
    end

    def index
        @users = User.order(money: :desc).limit(9)
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Welcome to the Sample App!"
            redirect_to root_path
        else
            render 'new'
        end
    end

    def show
        @user = User.find(params[:id])
        @posts = @user.posts
    end

    def search
        @post = Post.find(params[:post_id])
        @users = User.where('username LIKE ?', "%#{params[:username]}%")
    end
private

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
