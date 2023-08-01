class FavoritesController < ApplicationController
  before_action :set_post

  def index
    @favorites = current_user.favorites
  end

  def create
    current_user.favorites.create(post_id: @post.id)
    @post.create_notification_favorite!(current_user)
    redirect_to post_path(@post)
  end

  def destroy
    favorite = current_user.favorites.find(params[:id])
    favorite.destroy!
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
