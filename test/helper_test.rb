require File.join(File.dirname(__FILE__), 'test_helper')

class HelperAPI < Helmet::API
  
  helpers do
    def print_text(text)
      "text: #{text}"
    end
  end
  
  helpers do
    def x(num)
      'x' * num
    end
    
    def y(num)
      'y' * num
    end
  end
  
  get '/' do
    print_text params['text']
  end
  
  get '/xy' do
    x(params['x'].to_i) + y(params['y'].to_i)
  end
  
end

class HelperTest < Test::Unit::TestCase
  include Goliath::TestHelper

  # code from goliath test
  def setup
    @err = Proc.new { assert false, "API request failed" }
  end

  def test_helper_binding
    with_api(HelperAPI) do
      get_request({:query => {'text' => 'Hello'}}, @err) do |c|
        assert_equal 'text: Hello', c.response
      end
    end
  end
  
  def test_multiple_helpers_methods
    with_api(HelperAPI) do
      get_request({:path => '/xy', :query => {'x' => 5, 'y' => 10}}, @err) do |c|
        assert_equal "#{'x'*5}#{'y'*10}", c.response
      end
    end
  end    
end