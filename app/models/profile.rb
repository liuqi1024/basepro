class Profile < ActiveRecord::Base
  belongs_to :user

  attr_protected false
end
