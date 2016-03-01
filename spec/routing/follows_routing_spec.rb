require 'rspec-rails'

RSpec.describe FollowsController, type: :routing do
  describe 'routing' do

    it 'routes to #create' do
      expect(:post => '/follow').to route_to('follows#create')
    end

    it 'routes to #destroy' do
      expect(:delete => '/unfollow/1').to route_to('follows#destroy', id: '1')
    end

  end
end
