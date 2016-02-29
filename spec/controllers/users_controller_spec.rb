require 'spec_helper'

describe UsersController do

  describe 'view users index' do
    before do 
      get :index
    end
    it { should respond_with(:success) }
    it { should render_template(:index) }
  end  
end
