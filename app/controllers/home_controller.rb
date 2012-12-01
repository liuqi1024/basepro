require 'weibo_2'

class HomeController < ApplicationController
  def index
    return unless user_signed_in? 
    @name = current_user.name
    @avatar = case current_user.provider
              when "weibo"
                avatar_weibo
              when "twitter"
              when "qq_connect"
                avatar_qq
              when "github"
                avatar_github
              else
              end
  end
  
  private
  
  def avatar_weibo
    client = WeiboOAuth2::Client.new
    client.get_token_from_hash({:access_token=>session[:access_token], :expires_at=>session[:expires_at]})
    client.users.show_by_uid(current_user.uid).profile_image_url
  end
  
  def avatar_github
    hash = JSON.parse current_user.auth
    # hash["extra"]["raw_info"]["avatar_url"]
    hash["info"]["image"]
  end
  
  alias_method :avatar_qq, :avatar_github
end
