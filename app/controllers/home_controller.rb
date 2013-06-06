require 'weibo_2'

class HomeController < ApplicationController
  def index
    # raise current_user.auth.to_yaml
    return unless user_signed_in? 
    # @provider = current_user.provider
    # @uid      = current_user.uid
    # @token    = current_user.auth.credentials.token if current_user.auth.credentials
    # @expires_at = current_user.auth.credentials.expires_at if current_user.auth.credentials
    @name = current_user.name
    # @avatar = case current_user.provider
    #           when "weibo"
    #             avatar_weibo
    #           when "twitter"
    #             avatar_twitter
    #           when "qq_connect"
    #             avatar_qq
    #           when "github"
    #             avatar_github
    #           else
    #           end
    
    
  end
  
  private
  
  def avatar
    current_user.auth.info.image
  end
  
  alias_method :avatar_weibo,   :avatar
  alias_method :avatar_twitter, :avatar
  alias_method :avatar_github,  :avatar
  alias_method :avatar_qq,      :avatar
end
