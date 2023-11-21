require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it "is valid with valid attributes" do
      @user = User.new(first_name: "John", last_name: "Doe", email: "test@test.com", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
    end

    it "requires a password AND confirmation" do
      @user = User.new(first_name: "John", last_name: "Doe", email: "test@test.com", password: "password123", password_confirmation: "password")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "requires a unique email" do
      @user = User.create!(first_name: "John", last_name: "Doe", email: "123@test.com", password: "password", password_confirmation: "password")
      @user2 = User.new(first_name: "Johnny", last_name: "Doe", email: "123@test.com", password: "password", password_confirmation: "password")
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it "requires a unique email and is NOT case sensitive" do
      @user = User.create!(first_name: "John", last_name: "Doe", email: "123@test.com", password: "password", password_confirmation: "password")
      @user2 = User.new(first_name: "Johnny", last_name: "Doe", email: "123@TEST.com", password: "password", password_confirmation: "password")
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
    
    it "requires a password to be at least 5 characters long" do
      @user = User.new(first_name: "John", last_name: "Doe", email: "123@test.com", password: "pass", password_confirmation: "pass")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it "should return a user if the credentials are valid" do
      user = User.create!(first_name: "John", last_name: "Doe", email: "123@test.com", password: "password", password_confirmation: "password")
      expect(user).to be_valid
      expect(User.authenticate_with_credentials("123@test.com", "password")).to eq(user)
    end

    it "should return equal nil if the password is incorrect" do
      user = User.create!(first_name: "John", last_name: "Doe", email: "123@test.com", password: "password", password_confirmation: "password")
      expect(user).to be_valid
      expect(User.authenticate_with_credentials("123@test.com", "pass")).to eq(nil)
    end
    
    it "should retrun a user if the email is correct but has spaces before or after" do
      user = User.create!(first_name: "John", last_name: "Doe", email: "123@test.com", password: "password", password_confirmation: "password")
      expect(user).to be_valid
      expect(User.authenticate_with_credentials(" 123@test.com", "password")).to eq(user)
      expect(User.authenticate_with_credentials("123@test.com ", "password")).to eq(user)
    end

    it "should retrun a user if the email is correct but has mis-capitalized letters" do
      user = User.create!(first_name: "John", last_name: "Doe", email: "123@test.com", password: "password", password_confirmation: "password")
      expect(user).to be_valid
      expect(User.authenticate_with_credentials("123@TEST.com", "password")).to eq(user)
    end
  end

end