require 'spec_helper'

RSpec.describe 'messages/index', type: :view do
  before(:each) do
    create_user
    assign(:messages, [
      Message.create!(
        :user => @user,
        :text => 'Text'
      ),
      Message.create!(
        :user => @user,
        :text => 'Text'
      )
    ])
  end

  it 'renders a list of messages' do
    render
    assert_select 'ol>li .message-header span b', :text => @user.username.to_s, :count => 2
    assert_select 'ol>li>.message-body', :text => 'Text'.to_s, :count => 2
  end
end
