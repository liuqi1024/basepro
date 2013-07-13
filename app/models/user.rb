class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessor :login
         
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :login
  
  validates :name, :presence => true 
  validates_uniqueness_of :name, :if => "provider.blank?"
  
  # serialize auth
  store :auth
  
  has_one :profile
  
  before_save :init_profile
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  
  def self.from_omniauth(auth)
    user = where(auth.slice(:provider, :uid)).first
    if user
      user.update_attribute(:auth, auth)
    else
      user = User.new
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.nickname
      user.auth = auth
      user.save
    end
    user
    # where(auth.slice(:provider, :uid)).first_or_create! do |user|
    #   user.provider = auth.provider
    #   user.uid = auth.uid
    #   user.name = auth.info.nickname
    #   user.auth = auth
    # end
  end
  
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end    
  end
  
  def password_required?
    super && provider.blank?
  end
  
  def email_required?
    super && provider.blank?
  end
  
  def init_profile
    self.create_profile
  end
end





