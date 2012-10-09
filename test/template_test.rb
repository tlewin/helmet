require File.join(File.dirname(__FILE__), 'test_helper')

class TemplateAPI < Helmet::API
  
  get '/' do
    @test = 'test'
    erb :test
  end
  
end

class TemplateTest < Test::Unit::TestCase
  include Goliath::TestHelper
  
  # code from goliath test
  def setup
    @err = Proc.new { assert false, "API request failed" }
  end

  def test_template_binding
    with_api(TemplateAPI) do
      get_request({}, @err) do |c|
        assert_equal 'test', c.response
      end
    end
  end
end