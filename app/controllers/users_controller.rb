class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  before_action :authenticate_user!

  def index; end

  # GET /users/1
  # GET /users/1.json
  def show
    @followed = current_user.is_follower? @user
    @messages = @user.messages
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /profile
  # GET /profile.json
  def profile
    @message = Message.new
    @messages = Message.recent(current_user.followings.pluck(:id))
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /profile
  # GET /profile.json
  def followers
    @title = t(:follower).capitalize.pluralize
    @follows = current_user.followers_list
    respond_to do |format|
      format.js { render template: 'users/follows' }
    end
  end

  def followings
    @title = t(:following).capitalize.pluralize
    @follows = current_user.followings
    respond_to do |format|
      format.js { render template:'users/follows' }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

end
