class TransfersController < ApplicationController
    def create
        post = Post.find(params[:post_id])
        sender = post.user
        receiver = User.find(params[:user_id])
        amount = post.prize_money

        if sender.id != current_user.id
            redirect_to post, alert: '送金できません。'
        else
            ActiveRecord::Base.transaction do
            post.prize_money = 0
            post.save!
            receiver.money = (receiver.money || 0) + amount
            receiver.save!
            end
            redirect_to post, notice: 'お金が送られました。'
        end
    rescue ActiveRecord::RecordInvalid
        redirect_to post, alert: 'お金の送信に失敗しました。'
    end
end
