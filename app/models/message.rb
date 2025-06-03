class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_create_commit :notify_clients

  def notify_clients
    ActionCable.server.broadcast "room_#{room.id}", { message: self }
  end

  def confirm_participant
    true
  end
end
