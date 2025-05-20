class MessagesController < ApplicationController
  before_action :set_message, only: [:show]

  def index
    messages = Message.all
    render json: messages, status: :ok
  end

  def create
    message = Message.new(message_params)
    if message.save
      render json: message, status: :created
    else
      render json: { errors: message.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_message
    # Not needed in this case, but can be used if show action is implemented
  end

  def message_params
    params.require(:message).permit(:content, :user_id, :room_id)
  end
end