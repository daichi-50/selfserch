class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    PostChannel.broadcast_to(message.post, message: render_message(message))
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message_single', locals: { message: message })
  end
end
