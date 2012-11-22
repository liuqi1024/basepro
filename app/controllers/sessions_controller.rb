class SessionsController < Devise::SessionsController
def new
  puts 'user return to:'
  puts session[:user_return_to]
  super
    
end

end
