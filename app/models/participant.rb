class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_create_commit :notify_clients

  private

  def notify_clients
    $redis.publish("room:#{room.id}:participants", { participant: self }.to_json)
  end
end
