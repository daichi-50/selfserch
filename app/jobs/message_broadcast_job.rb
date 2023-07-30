class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    Rails.logger.info "Broadcasting message #{message.id}"
    PostChannel.broadcast_to(message.post, message: render_message(message))
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message, user_id: message.user_id })
  end
end
