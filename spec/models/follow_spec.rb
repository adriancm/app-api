require 'rspec-rails'

RSpec.describe Follow, type: :model do

  describe 'view documentation index' do
    before do
      create_n_users(4)
      Follow.new(follower: @users.first, followed: @users.second).save
      @follow = Follow.new(follower: @users.first, followed: @users.last)
    end

    it 'should be valid' do
      expect(@follow.valid?).to eq(true)
    end

    it 'should be invalid, can not be followed twice' do
      @follow.followed = @users.second
      expect(@follow.valid?).to eq(false)
    end

    it 'should require a follower' do
      @follow.follower = nil
      expect(@follow.valid?).to eq(false)
    end

    it 'should require a followed' do
      @follow.followed = nil
      expect(@follow.valid?).to eq(false)
    end

  end

end
