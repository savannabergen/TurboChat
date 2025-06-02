class HomeController < ApplicationController
  def index

    output = "############################\n"
    output += "#                          #\n"
    output += "#  S A V A N N A ' S  A P I  #\n"
    output += "#                          #\n"
    output += "############################\n\n"

    render plain: output
  end
end