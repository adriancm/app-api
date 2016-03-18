require 'spec_helper'

describe User, type: :model do
  describe 'view documentation index' do

    before do
      create_n_users(2)
      @user1 = @users.first
      @user2 = @users.second
    end

    it 'should be invalid same username' do
      @user2.username = @user1.username
      expect(@user1.valid?).to eq(true)
      expect(@user2.valid?).to eq(false)
    end

    it 'should be invalid same username' do
      expect(@user1.valid?).to eq(true)
      expect(@user2.valid?).to eq(true)
    end

    it 'should be invalid same username' do
      @user2.email = @user1.email
      expect(@user1.valid?).to eq(true)
      expect(@user2.valid?).to eq(false)
    end

  end
end
