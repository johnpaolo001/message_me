class MessagesController < ApplicationController
    before_action :require_user

    def create
        message = current_user.messages.build(messsage_params)
        if message.save
            ActionCable.server.broadcast "chatroom_channel",
                                        foo: message.body
        end
    end

    private

    def messsage_params
        params.require(:message).permit(:body)
    end

end