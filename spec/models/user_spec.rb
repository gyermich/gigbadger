require 'spec_helper'

describe User do

    before(:each) do
      @user = FactoryGirl.create(:user)
    end

  describe 'validates' do
    it 'is valid' do
      expect(@user).to be_valid
    end

    it 'must have name' do
      @user.update(name: nil)
      expect(@user).to_not be_valid
    end

    it 'must have email' do
      @user.update(email: nil)
      expect(@user).to_not be_valid
    end

    it 'email is unique' do
      @user2 = build(:user, email: @user.email)
      expect(@user2).to_not be_valid
    end
  end
end
