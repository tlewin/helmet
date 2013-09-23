require File.join(File.dirname(__FILE__), 'test_helper')

class RouterAPI < Helmet::API

  get '/user/:id' do
    "Hello user #{params[:id]}"
  end

end

class HttpRouterTest < Test::Unit::TestCase
  include Goliath::TestHelper

  def setup
    @err = Proc.new { assert false, "API request failed" }
  end

  def test_url_params
    with_api(RouterAPI) do
      get_request({path: '/user/3'}, @err) do |c|
        assert_equal 'Hello user 3', c.response
      end
    end
  end

end