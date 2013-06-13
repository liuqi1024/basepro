require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = {
      :login => "example user",
      :email => "user@example.com",
      :name => "ken",
      :password => "111111",
      :password_confirmation => "111111"
    }
  end
  
  it "should create a new user given a valid attribute" do
    User.create!(@attr)
  end
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(email: ""))
    no_email_user.should_not be_valid
  end
  
  it "should accept valid email address" do
    
  end
  
  it "should reject invalid email address" do
    
  end
  
  it "should reject duplicate email address" do
    
  end
  
  it "should reject email address identical up to case" do
    
  end
  
  describe "passwords" do
    
    before(:each) do
      @user = User.new(@attr)
    end
    
    it "should have a password attribute" do
      @user.should respond_to(:password)
    end
    
    it "should have a password confirmation attribute" do
      
    end
  end
  
  describe "password validations" do
    
    it "should require a password" do
      User.new(@attr.merge(password: "", password_confirmation: "")).
        should_not be_valid
    end
    
    it "should require a matching password confirmation" do
      
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(password: short, password_confirmation: short)
      User.new(hash).should_not be_valid
    end
  end
  
  describe "password encryption" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end
  end
end
















