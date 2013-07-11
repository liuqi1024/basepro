class Admin::UserController < ApplicationController
  def edit
    @user = current_user
  end
  
  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(params[:user])
      
      sign_in @user, bypass: true
      redirect_to admin_root_path
    else
      render 'edit'
    end
  end
  
  private
  
  # def user_params
  #   params.required(:user).permit(:password, :password_confirmation)
  # end
end
