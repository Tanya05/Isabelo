class RegistrationsController < Devise::RegistrationsController

  def update
    super
    sign_in(current_user, :bypass => true)
  end

  
  private #overriding params function
  def sign_up_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation, :address)
  end

  def account_update_params
  	params.require(:user).permit(:name, :address, :email, :password, :password_confirmation, :current_password)
  end

  def profile_update_params
  	params.require(:user).permit(:name, :address, :email)
  end


end