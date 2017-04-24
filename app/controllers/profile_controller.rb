class ProfileController < ApplicationController
  def viewAccount
    @user = current_user
  end
end
