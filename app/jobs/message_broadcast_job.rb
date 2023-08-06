class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    Rails.logger.info "Broadcasting message #{message.id}"
    PostChannel.broadcast_to(message.post, message: render_message(message), second_message: render_second_message(message), sender_id: message.user_id)
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/own_message', locals: { message: message })
  end

  def render_second_message(message)
    ApplicationController.renderer.render(partial: 'messages/other_message', locals: { message: message })
  end
end
