class HangoutsController < ApplicationController
  def index
    @messages = Message.includes(:user)
    @message = Message.new
  end

  def create
    @message = current_user.messages.build(message_params)
    @message.save
    ActionCable.server.broadcast('message', @message.as_json(include: :user))
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

end
