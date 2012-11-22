class SessionsController < Devise::SessionsController

  def after_sign_in_path_for(resource)
    if resource.has_role? 'admin'
      admin_root_path
    else
      stored_location_for(resource) || signed_in_root_path(resource)
    end
  end
end
