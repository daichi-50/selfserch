class PostChannel < ApplicationCable::Channel
  def subscribed
    post = Post.find(params[:post_id])
    stream_for post
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    post = Post.find(data['post_id'])
    content = data['message'].strip # メッセージの前後の空白を削除
    return unless content.present? # メッセージが空でないことを確認

    # メッセージの作成だけ行い、ブロードキャストは after_commit フックに任せる
    post.messages.create!(content:, user_id: current_user.id)
    sleep(0.1)
    if post.user_id != current_user.id
    post.create_notification_message!(current_user, post.messages.last.id)
    end
  end
end
