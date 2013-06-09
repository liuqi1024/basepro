class Photo < ActiveRecord::Base

  belongs_to :owner, :polymorphic => true
  
  has_attached_file :source, :styles => { :large => "640x640>", :medium => "300x300>", :thumb => "150x150>"}
  
end
