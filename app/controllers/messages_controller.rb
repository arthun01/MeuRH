class MessagesController < ApplicationController
  def index
    @messages = Message.order(created_at: :asc).last(100)
    @new_message = Message.new
  end

  def create
    @message = current_user.messages.build(message_params)
    @message.save
    
    respond_to do |format|
      if @message.persisted?
        format.turbo_stream
        format.html { redirect_to messages_path }
      else
        format.html { redirect_to messages_path, alert: "Erro ao enviar mensagem." }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
