class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    Rails.logger.info "Broadcasting message #{message.id}"
    PostChannel.broadcast_to(message.post, message: render_message(message))
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: select_partial(message), locals: { message: message })
  end

  def select_partial(message)
    message.user.id == message.user_id ? 'messages/own_message' : 'messages/other_message'
  end
end
