$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'helmet/api'
require 'goliath/runner'

class Test < Helmet::API

  get '/' do
    'test'
  end

end

runner = Goliath::Runner.new(ARGV, nil)
runner.api = Test.new
runner.app = Goliath::Rack::Builder.build(Test, runner.api)
runner.run

