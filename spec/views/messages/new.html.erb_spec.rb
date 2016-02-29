require 'spec_helper'

RSpec.describe "messages/new", type: :view do
  before(:each) do
    create_user
    assign(:message, Message.new(
      :user => @user,
      :text => 'MyString'
    ))
  end

  it 'renders new message form' do
    render
    assert_select 'form[action=?][method=?]', messages_path, 'post' do
      assert_select 'textarea#message_text[name=?]', 'message[text]'
    end
  end
end
