class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    def index
        @posts = Post.all
    end

    def show; end

    def new
        @post = current_user.posts.build
    end

    def create
        @post = current_user.posts.build(post_params)

        @post.create_image(title: @post.title, description: @post.description)

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
        params.require(:post).permit(:image, :title, :user_height, :user_weight, :description, :when, :image_data_url)
    end

    def set_post
        @post = current_user.posts.find(params[:id])
    end
end
