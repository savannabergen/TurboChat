class NotifyClientsJob < ApplicationJob
  queue_as :default

  def perform(user)
    $redis.publish("users", { user: user }.to_json)
  end
end