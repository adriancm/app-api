class MessagesController < ApplicationController
  before_action :set_message, only: [:destroy]

  before_action :authenticate_user!

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.user ||= current_user
    respond_to do |format|
      if @message.save
        format.html { redirect_to profile_path, notice: t(:message_created) }
        format.json { render json: @message, status: :created }
      else
        format.html { render template: 'users/profile' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to profile_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:user_id, :text)
    end
end
