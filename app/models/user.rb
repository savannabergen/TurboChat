class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  scope :all_except, ->(user) { where.not(id: user) }
  after_create_commit :notify_clients
  after_commit :attach_default_avatar, on: :create
  has_many :messages, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy

  def avatar_thumbnail
    avatar.variant(resize_to_limit: [150, 150]).processed
  end

  def chat_avatar
    avatar.attached? ? avatar.variant(resize_to_limit: [50, 50]).processed : AvatarService.default_avatar_url
  end

  private

  def attach_default_avatar
    AvatarService.attach_default_avatar(self) unless avatar.attached?
  end

  def notify_clients
    NotifyClientsJob.perform_later(self)
  end
end
