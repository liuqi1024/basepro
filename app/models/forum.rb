class Forum < ActiveRecord::Base
  belongs_to :cover
  attr_accessible :desc, :title
end
