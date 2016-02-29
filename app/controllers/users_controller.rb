class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index; end

  # GET /users/1
  # GET /users/1.json
  def show
    @message = Message.new
    @followed = current_user.try(:follow?, @user)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def profile
    @message = Message.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

end
