class MessagesController < ApplicationController
  def show
    #共通化可能ブロック
    is_followed = current_user.is_followed(params[:user_id].to_i())
    is_following = current_user.is_following(params[:user_id].to_i())
    if not is_followed && is_following then
      return redirect_to users_path
    end
    ####

    @message = Message.new
    @messages = Message.where(sender_id: current_user.id, reciever_id: params[:user_id])
      .or(Message.where(sender_id: params[:user_id], reciever_id: current_user.id))

      @reciever_name = User.find(params[:user_id]).name
  end

  def create
    ## 共通化可能ブロック
    is_followed = current_user.is_followed(params[:user_id].to_i())
    is_following = current_user.is_following(params[:user_id].to_i())
    if not is_followed && is_following then
      return redirect_to users_path
    end
    ####

    message = Message.new(message_params)
    message.sender_id = current_user.id
    message.reciever_id = params[:user_id]
    if message.save() then
      redirect_to request.referer
    else
      ## 共通化可能ブロック
      @message = message
      @messages = Message.where(sender_id: current_user.id, reciever_id: params[:user_id])
        .or(Message.where(sender_id: params[:user_id], reciever_id: current_user.id))
  
        @reciever_name = User.find(params[:user_id]).name
      render "show"
      ####
    end

  end

  private

  def message_params
    params.require(:message).permit(:text)
  end
end
