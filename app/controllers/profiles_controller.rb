# encoding: utf-8
class ProfilesController < ApplicationController
  before_filter :find_profile_by_user_id
  
  def show
    
  end

  def edit
    
  end
  
  def update
    current_user.profile.update_attributes(params[:profile])
    
    redirect_to edit_profile_url
  end
  
  private
  
  def find_profile_by_user_id
    user = User.find(params[:id])
    # user.create_profile unless user.profile # 如果在user的before save的时候做了，这步可以省略。
    @profile = user.profile
  end
  
end
