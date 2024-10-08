# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, only: [:create, :update]

  def create
    build_resource(sign_up_params)

    otp_code = generate_otp
    resource.update(otp_secret: otp_code, otp_sent_at: Time.current)

    if resource.save(validate: false)
      UserMailer.send_otp(resource.email, otp_code).deliver_now

      session[:otp_user_id] = resource.id
      redirect_to otp_verification_path
    else
      clean_up_passwords(resource)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def generate_otp
    SecureRandom.hex(4).to_s
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :department])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role, :department])
  end
end
