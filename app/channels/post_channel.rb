class PostChannel < ApplicationCable::Channel
  def subscribed
    post = Post.find(params[:post_id])
    stream_for post
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    post = Post.find(data["post_id"])
    message = post.messages.create!(content: data["message"], user: current_user) 
    template = ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
    PostChannel.broadcast_to post, template
  end
end
