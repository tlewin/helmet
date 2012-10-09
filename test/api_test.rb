require File.join(File.dirname(__FILE__), 'test_helper')

require 'uri'

class Simple < Helmet::API
  
  before /\/x\w*$/ do
    halt 'filtered!'
  end
  
  get '/' do
    'get'
  end
  
  post '/' do
    'post'
  end
  
  put '/' do
    'put'
  end
  
  delete '/' do
    'delete'
  end
  
  get '/redirect' do
    redirect '/redirected'
  end
end

class APITest < Test::Unit::TestCase
  include Goliath::TestHelper

  # code from goliath test
  def setup
    @err = Proc.new { assert false, "API request failed" }
  end
  
  def test_get
    with_api(Simple) do
      get_request({}, @err) do |c|
        assert_equal 'get', c.response
      end
    end
  end
  
  def test_post
    with_api(Simple) do
      post_request({}, @err) do |c|
        assert_equal 'post', c.response
      end
    end
  end
  
  def test_put
    with_api(Simple) do
      put_request({}, @err) do |c|
        assert_equal 'put', c.response
      end
    end
  end
  
  def test_delete
    with_api(Simple) do
      delete_request({}, @err) do |c|
        assert_equal 'delete', c.response
      end
    end
  end

  def test_filter
    with_api(Simple) do
      get_request({:path => '/xx'}, @err) do |c|
        assert_equal 'filtered!', c.response
      end
    end
  end
  
  def test_redirected
    with_api(Simple) do
      get_request({:path => '/redirect'}, @err) do |c|
        assert_equal c.response_header.status, 302
        uri = URI.parse(c.response_header['LOCATION'])
        assert_equal '/redirected', uri.path
      end
    end
  end
  
end
