class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_create_commit :notify_clients

  private

  def notify_clients
    ActionCable.server.broadcast "room_#{room.id}:participants", { participant: self }
  end
end
