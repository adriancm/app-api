require 'spec_helper'

RSpec.describe Message, type: :model do
  describe 'view documentation index' do
    before do
      create_user
      @message = Message.new(user: @user, text: 'test')
    end

    it 'should be valid' do
      expect(@message.valid?).to eq(true)
    end

    it 'should require a user' do
      @message.user = nil
      expect(@message.valid?).to eq(false)
    end

    it 'should require a text' do
      @message.text = nil
      expect(@message.valid?).to eq(false)
    end

    it 'text can not be bigger than 160' do
      @message.text = 'a'*161
      expect(@message.valid?).to eq(false)
    end

  end
end
