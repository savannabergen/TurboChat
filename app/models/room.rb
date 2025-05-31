class Room < ApplicationRecord
  validates_uniqueness_of :name
  scope :public_rooms, -> { where(is_private: false) }
  after_create_commit :notify_clients
  after_create_commit :add_participants
  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy

  def notify_clients
    $redis.publish("rooms", { room: self }.to_json) unless is_private
  end

  def self.create_private_room(users, room_name)
    single_room = Room.create(name: room_name, is_private: true)
    users.each do |user|
      Participant.create(user_id: user.id, room_id: single_room.id)
    end
    single_room
  end

  def participant?(user)
    participants.where(user: user).exists?
  end

  private

  def add_participants
    User.all.each do |user|
      Participant.find_or_create_by(user: user, room: self)
    end
  end
end
