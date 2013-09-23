require File.join(File.dirname(__FILE__), 'test_helper')

class RouterAPI < Helmet::API

  before '/user/:id' do
    halt "Halt user #{params[:id]}" if params[:id] == '11'
  end

  before '/clean/:user/1' do
    "Clean/ #{params[:user] || 'nil'}/ #{params[:id] || 'nil'}"
  end

  before '/clean/test/:id' do
    [body, "Clean/ #{params[:user] || 'nil'}/ #{params[:id] || 'nil'}"] * ','
  end

  get '/user/:id' do
    "Hello user #{params[:id]}"
  end

  get '/clean/:user/:id' do
    body
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

  def test_before_filters_params 
    with_api(RouterAPI) do
      get_request({path: '/user/11'}, @err) do |c|
        assert_equal 'Halt user 11', c.response
      end
    end
  end

  def test_clean_params_for_each_route 
    with_api(RouterAPI) do
      get_request({path: '/clean/test/1'}, @err) do |c|
        assert_equal 'Clean/ test/ nil,Clean/ nil/ 1', c.response
      end
    end      
  end

end