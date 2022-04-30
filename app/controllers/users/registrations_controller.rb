# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :set_sideber_data, only: [:edit, :update]
    # before_action :configure_account_update_params, only: [:update]

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    def create
      super
      user = User.find_by(email: params[:user][:email])
      if !user.nil?
        user.create_glider_initial_log!(at_present: Date.today,
                                        non_power_total_time: 0,
                                        non_power_total_number: 0,
                                        pic_winch_time: 0,
                                        pic_winch_number: 0,
                                        pic_aero_tow_time: 0,
                                        pic_aero_tow_number: 0,
                                        solo_winch_time: 0,
                                        solo_winch_number: 0,
                                        solo_aero_tow_time: 0,
                                        solo_aero_tow_number: 0,
                                        dual_winch_time: 0,
                                        dual_winch_number: 0,
                                        dual_aero_tow_time: 0,
                                        dual_aero_tow_number: 0,
                                        power_total_time: 0,
                                        power_total_number: 0,
                                        pic_power_time: 0,
                                        pic_power_number: 0,
                                        pic_power_off_time: 0,
                                        pic_power_off_number: 0,
                                        solo_power_time: 0,
                                        solo_power_number: 0,
                                        solo_power_off_time: 0,
                                        solo_power_off_number: 0,
                                        dual_power_time: 0,
                                        dual_power_number: 0,
                                        dual_power_off_time: 0,
                                        dual_power_off_number: 0,
                                        cross_country_time: 0,
                                        instructor_time: 0,
                                        instructor_number: 0,
                                        number_of_stall_recovery: 0)
      end
    end

    # GET /resource/edit
    # def edit
    #   super
    #   user_url(resource)
    # end

    # PUT /resource
    # def update
    #   super
    #   user_url(resource)
    # end

    # DELETE /resource
    # def destroy
    #   super
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password])
    end

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_account_update_params
    #   devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :encrypted_password])
    # end

    # The path used after sign up.
    def after_sign_up_path_for(resource)
      user_url(resource)
    end

    # The path used after sign up for inactive accounts.
    def after_inactive_sign_up_path_for(resource)
      new_user_session_url
    end
  end
end
