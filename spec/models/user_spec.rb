require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    # before do
    #   @category = Category.new(:name => "Toys")
    #   @name = "New Product"
    #   @price = 20
    #   @quantity = 3
    # end

    it "accepts user with all fields" do
      @user = User.create(:first_name => "Paul", :last_name => "Chen", :email => "pc647@gmail.com", :password=>"password123", :password_confirmation=>"password123")      
      expect(@user).to be_valid
      expect(@user.errors.full_messages.empty?).to be_truthy
    end

    it "does not accept user with no first name" do
      @user = User.create(:first_name => nil, :last_name => "Chen", :email => "pc647@gmail.com", :password=>"password123", :password_confirmation=>"password123")      
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.empty?).to_not be_truthy
    end

    it "does not accept user with no last name" do
      @user = User.create(:first_name => "Paul", :last_name => nil, :email => "pc647@gmail.com", :password=>"password123", :password_confirmation=>"password123")      
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.empty?).to_not be_truthy
    end

    it "does not accept user with no email" do
      @user = User.create(:first_name => "Paul", :last_name => "Chen", :email => nil, :password=>"password123", :password_confirmation=>"password123")      
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.empty?).to_not be_truthy
    end

    it "does not accept user with no passwords" do
      @user = User.create(:first_name => "Paul", :last_name => "Chen", :email => "pc647@gmail.com", :password=>nil, :password_confirmation=>nil)      
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.empty?).to_not be_truthy
    end

    it "does not accept identical emails" do
      @user1 = User.create(:first_name => "Paul", :last_name => "Chen", :email => "pc647@gmail.com", :password=>"password123", :password_confirmation=>"password123")      
      expect(@user1).to be_valid
      
      @user2 = User.create(:first_name => "Another", :last_name => "User", :email => "pc647@gmail.com", :password=>"password123", :password_confirmation=>"password123")      
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages.empty?).to_not be_truthy
    end

    it "does not accept invalid emails" do
      @user = User.create(:first_name => "Paul", :last_name => "Chen", :email => "pc647", :password=>"password123", :password_confirmation=>"password123")      
      expect(@user).to_not be_valid
      
  
    end

    it "does not accept identical case-insensitive emails" do
      @user1 = User.create(:first_name => "Paul", :last_name => "Chen", :email => "pc647@gmail.com", :password=>"password123", :password_confirmation=>"password123")      
      expect(@user1).to be_valid
      
      @user2 = User.create(:first_name => "Another", :last_name => "User", :email => "PC647@GMAIL.COM", :password=>"password123", :password_confirmation=>"password123")      
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages.empty?).to_not be_truthy
    end

    it "does not accept passwords below 6 characters" do
      @user = User.create(:first_name => "Paul", :last_name => "Chen", :email => "PC647@GMAIL.COM", :password=>"passw", :password_confirmation=>"passw")      
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.empty?).to_not be_truthy
    end

    it "does not accept passwords with mismatching confirmations" do
      @user = User.create(:first_name => "Paul", :last_name => "Chen", :email => "PC647@GMAIL.COM", :password=>"password123", :password_confirmation=>"password456")      
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.empty?).to_not be_truthy
    end

  end

  describe '.authenticate_with_credentials' do
    it "authenticates users with right credentials" do
      @user = User.create(:first_name => "Paul", :last_name => "Chen", :email => "pc647@gmail.com", :password=>"password123", :password_confirmation=>"password123")      
      expect(@user).to be_valid
      @result_user = User.authenticate_with_credentials("pc647@gmail.com", "password123") 
      expect(@result_user).to be_truthy

    end

    it "does not authenticate users with incorrect credentials" do
      @user = User.create(:first_name => "Paul", :last_name => "Chen", :email => "pc647@gmail.com", :password=>"password123", :password_confirmation=>"password123")      
      expect(@user).to be_valid
      @result_user = User.authenticate_with_credentials("hello@gmail.com", "password456") 
      expect(@result_user).to_not be_truthy

    end

    it "authenticates users with right credentials but with spaces in emails" do
      @user = User.create(:first_name => "Paul", :last_name => "Chen", :email => "pc647@gmail.com", :password=>"password123", :password_confirmation=>"password123")      
      expect(@user).to be_valid
      @result_user = User.authenticate_with_credentials(" pc647@gmail.com ", "password123") 
      expect(@result_user).to be_truthy

    end

    it "authenticates users with right credentials but with wrong cases" do
      @user = User.create(:first_name => "Paul", :last_name => "Chen", :email => "pc647@gmail.com", :password=>"password123", :password_confirmation=>"password123")      
      expect(@user).to be_valid
      @result_user = User.authenticate_with_credentials("pc647@GMAIL.com", "password123") 
      expect(@result_user).to be_truthy

    end
  end
end
