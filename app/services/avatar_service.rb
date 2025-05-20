require 'open-uri'

class AvatarService
  def self.attach_default_avatar(user)
    return if user.avatar.attached?
    avatar_url = "https://picsum.photos/200/200"
    begin
      user.avatar.attach(io: URI.open(avatar_url), filename: "avatar.jpg", content_type: "image/jpeg")
    rescue OpenURI::HTTPError, IOError => e
      Rails.logger.error("Error attaching default avatar: #{e.message}")
    end
  end
end