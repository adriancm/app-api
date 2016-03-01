require 'spec_helper'

describe UsersController do

  describe 'view users index' do
    login_user

    before do
      create_user
      get :index
    end

    it 'should have a current_user' do
      expect(subject.current_user).to_not eq(nil)
    end

    it { should respond_with(:success) }
    it { should render_template(:index) }
  end  
end
