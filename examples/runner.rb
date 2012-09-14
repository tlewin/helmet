$LOAD_PATH.unshift File.join('..', 'lib')
require 'helmet/api'
require 'goliath/runner'

class Test < Helmet::API

  get '/' do |env|
    [200, {}, 'test']
  end

end

runner = Goliath::Runner.new([], nil)
runner.api = Test.new
runner.app = Goliath::Rack::Builder.build(Test, runner.api)
runner.run

