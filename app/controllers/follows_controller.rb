class FollowsController < ApplicationController
  before_action :set_follow, only: [:destroy]

  before_action :authenticate_user!

  # POST /follows
  # POST /follows.json
  def create
    @follow = Follow.new(follow_params)

    respond_to do |format|
      if @follow.save
        format.html { redirect_to profile_path, notice: t(:following) }
        format.json { render json: @follow.id, status: :created }
      else
        @user = @follow.followed
        @followed = false
        format.html { render template: 'users/show' }
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /follows/1
  # DELETE /follows/1.json
  def destroy
    @follow.destroy
    respond_to do |format|
      format.html { redirect_to profile_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_follow
      @follow = Follow.find_by(follower_id: params[:id], followed_id: current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def follow_params
      params.require(:follow).permit(:follower_id).merge(followed_id: current_user.id)
    end
end
