require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User validations' do

    it 'should create a valid user with all fields' do
      @user = User.create(first_name: "John", last_name: "Smith", email: "test@test.com", password: "123", password_confirmation: "123")
      p @user.errors.full_messages
      expect(@user.id).to be_present
    end

    it 'validation should check if password and password_confirmation are identical' do
      @user = User.create(first_name: "John", last_name: "Smith", email: "test@test.com", password: "123", password_confirmation: "777")
      expect(@user.errors.full_messages).to be_present
    end

    it 'validation should check if password and password_confirmation are present' do
      @user = User.create(first_name: "John", last_name: "Smith", email: "test@test.com", password: nil, password_confirmation: nil)
      expect(@user.errors.full_messages).to be_present
    end

    it 'validation should check email is unique' do
      User.create(first_name: "Jane", last_name: "Doe", email: "test@test.com", password: "123", password_confirmation: "123")
      @user = User.create(first_name: "John", last_name: "Smith", email: "TEST@test.com", password: "123", password_confirmation: "123")
      expect(@user.errors.full_messages).to be_present
    end

    it 'validation should check if email, first_name and last_name are present ' do
      @user = User.create(first_name: nil, last_name: nil, email: nil, password: "123", password_confirmation: "2")
      expect(@user.errors.full_messages).to be_present
    end

    it 'validation should should if password meets a minimum length' do
      @user = User.create(first_name: "John", last_name: "Smith", email: "test@test.com", password: "1", password_confirmation: "1")
      expect(@user.errors.full_messages).to be_present
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should return true given a password' do
      User.create(first_name: "John", last_name: "Smith", email: "test@test.com", password: "123", password_confirmation: "123")
      expect(User.authenticate_with_credentials("test@test.com", "123")).to_not be false
    end

    it 'should allow users to log in with spaces around their email input' do
      User.create(first_name: "John", last_name: "Smith", email: "test@test.com", password: "123", password_confirmation: "123")
      expect(User.authenticate_with_credentials("   test@test.com    ", "123")).to_not be nil
    end

    it 'should allow users to log in with wrong cases in their email input' do
      User.create(first_name: "John", last_name: "Smith", email: "test@test.com", password: "123", password_confirmation: "123")
      expect(User.authenticate_with_credentials("teST@teSt.cOm", "123")).to_not be nil
    end

  end

end
