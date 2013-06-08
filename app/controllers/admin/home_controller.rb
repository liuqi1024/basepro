class Admin::HomeController < Admin::BaseController
  def index
    @users = User.all
  end
  
end
