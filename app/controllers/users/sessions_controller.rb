class Users::SessionsController < Devise::SessionsController
  def create
    user = User.find_by(email: params[:user][:email])
    
    if user && user.valid_password?(params[:user][:password])
      user.otp_secret = SecureRandom.hex(4) # Generates a 4-byte OTP (8 characters)
      user.otp_sent_at = Time.current
  
      if user.save
        UserMailer.send_otp(user.email, user.otp_secret).deliver_now
  
        session[:otp_user_id] = user.id
        redirect_to otp_verification_path
      else
        flash.now[:alert] = "Unable to generate OTP. Please try again."
        render :new, status: :unprocessable_entity
      end
    else
      super
    end
  end

  def otp_verification
    # Render OTP verification view
  end

  def verify_otp
    user = User.find(session[:otp_user_id]) # Retrieve user from session

    if params[:otp] == user.otp_secret && user.otp_sent_at > 5.minutes.ago # Check OTP and expiration
      sign_in(user) # Sign in the user
      session.delete(:otp_user_id) # Clean up the session
      redirect_to root_path, notice: 'Successfully logged in!'
    else
      flash.now[:alert] = "Invalid OTP or OTP expired."
      render :otp_verification, status: :unprocessable_entity
    end
  end
end
