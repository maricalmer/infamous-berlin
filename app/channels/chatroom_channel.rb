 class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    # make channel specific to 1 chatroom
    chatroom = Chatroom.find(params[:id])
    stream_for chatroom
  end
end
