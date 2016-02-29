require 'spec_helper'

RSpec.describe 'messages/show', type: :view do
  before(:each) do
    create_user
    @message = assign(:message, Message.create!(
      :user => @user,
      :text => 'Text'
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Text/)
  end
end
