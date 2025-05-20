class HomeController < ApplicationController
  def index
    rooms = Room.all
    users = User.all
    messages = Message.all

    output = "############################\n"
    output += "#                          #\n"
    output += "#  S A V A N N A ' S  A P I  #\n"
    output += "#                          #\n"
    output += "############################\n\n"

    output += "Rooms:\n\n"
    rooms.each do |room|
      output += "#{room.name} (#{room.is_private ? 'Private' : 'Public'})\n"
    end

    output += "\nUsers:\n\n"
    users.each do |user|
      output += "#{user.email}\n"
    end

    output += "\nRecent Messages:\n\n"
    messages.each do |message|
      output += "Room: #{Room.find(message.room_id).name}, User: #{User.find(message.user_id).email}, Message: #{message.body}\n"
    end

    render plain: output
  end
end