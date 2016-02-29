module Api::V1::BaseApiHelper

  def paginate_api(resource, params = {})
    params = {} if params.is_a?(NilClass)
    if resource.is_a?(Array)
      resource = Kaminari.paginate_array(resource).page(params[:page] || 1)
    else
      resource = resource.page(params[:page] || 1)
    end

    if params[:per_page]
      resource = resource.per(params[:per_page])
    end
    resource
  end

  def access_token_expiration
    time = Time.at(ENV['DOORKEEPER_ACCESS_TOKEN_EXPIRATION'].to_i).utc
    if time < Time.at(60).utc
      time.utc.strftime('%S secondos')
    elsif time > Time.at(120).utc
      time.utc.strftime('%H hours %M minutes and %S seconds')
    else
      time.utc.strftime('%M minutes and %S seconds')
    end
  end

  def user_sign_up_params
    ActionController::Parameters.new(params).require(:user).permit(:email, :password, :username)
  end

  def social_account_params
    ActionController::Parameters.new(params).require(:user).permit(:uid, :provider, :email, :username)
  end

  def user_params
    ActionController::Parameters.new(params).require(:user).permit(:email, :password, :username,:first_name, :last_name, :avatar, :birthdate, :description, :phone_number, address_attributes: [:latitude, :longitude, :raw_address])
  end

  def password_params
    ActionController::Parameters.new(params).require(:user).permit(:email)
  end

  def successfully_sent?(resource)
    if Devise.paranoid
     resource.errors.clear
     :send_paranoid_instructions
    elsif resource.errors.empty?
     :send_instructions
    end
  end

  def response_ok
    { status: 'OK' }
  end

end
