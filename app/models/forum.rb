class Forum < ActiveRecord::Base
  has_one :cover, :class_name => 'Photo', :as => :owner, :dependent => :destroy
  
  attr_accessible :desc, :title
end
