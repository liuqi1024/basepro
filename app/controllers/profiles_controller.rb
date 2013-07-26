# encoding: utf-8
class ProfilesController < ApplicationController
  before_filter :find_self_profile
  
  def show
    
  end

  def edit
    
  end
  
  def update
    current_user.profile.update_attributes(params[:profile])
    
    redirect_to edit_profile_url(current_user)
  end
  
  def edit_secure
    @user = current_user
  end
  
  def update_secure
    @user = current_user
    
    @user.update_without_password(params[:user])
  end
  
  private
  
  def find_self_profile
    # user = User.find(params[:id])
    # user.create_profile unless user.profile # 如果在user的before save的时候做了，这步可以省略。
    @profile = current_user.profile
  end
  
end
