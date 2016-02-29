require 'spec_helper'

RSpec.describe "messages/edit", type: :view do
  before(:each) do
    create_user
    @message = assign(:message, Message.create!(
      :user => @user,
      :text => 'MyString'
    ))
  end

  it 'renders the edit message form' do
    render
    assert_select 'form[action=?][method=?]', message_path(@message), 'post' do
      assert_select 'textarea#message_text[name=?]', 'message[text]'
    end
  end
end
