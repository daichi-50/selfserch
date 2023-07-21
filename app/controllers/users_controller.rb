class UsersController < ApplicationController
  def index
    @users = User.order(money: :desc).limit(9)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(3).order(created_at: :desc)
  end

  def search
    @post = Post.find(params[:post_id])
    @users = User.where('username LIKE ?', "%#{params[:username]}%")
  end

  def favorites
    @user = User.find(params[:id])
    @favorite_posts = @user.favorites.joins(:post).page(params[:page]).per(3).order(created_at: :desc)
  end

  def autocomplete_user_username
    @users = User.where('username LIKE ?', "#{params[:query]}%")

    respond_to do |format|
      format.html do
        render partial: 'users/autocomplete', locals: { users: @users }, layout: false
      end
    end
  end
end
