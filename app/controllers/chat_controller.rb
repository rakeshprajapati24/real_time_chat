class ChatController < ApplicationController
  before_action :authenticate_admin
  def chat_page
    session[:selected_user] = params[:id]
    @users = User.all
    @messages = Message.where("(receive_id = ? and user_id =?) or (receive_id = ? and user_id =?)",params[:id],current_user.id,current_user.id,params[:id])
    @message = Message.new
  end

  def create_message
    @message = current_user.messages.build(message_params)
    @message.receive_id = params[:message][:receive_id]

    if @message.save
      # ActionCable.server.broadcast('chat_channel', render_message(@message, @message.receive_id))
      message_data = { message: @message.content, receiver_id: @message.receive_id,user_id:@message.user_id }.to_json
      ActionCable.server.broadcast('chat_channel', message_data)
      head :ok
    else
      render json: { error: @message.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  # def render_message(message)
  #   ApplicationController.render(
  #     partial: 'messages/message',
  #     locals: { message: message }
  #   )
  # end
   def render_message(message, receiver_id,user_id)
    ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message, receiver_id: receiver_id ,user_id:user_id}
    )
  end

  def message_params
    params.require(:message).permit!
  end
end
