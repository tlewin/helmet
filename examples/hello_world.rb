$LOAD_PATH.unshift File.join('..', 'lib')
require 'helmet'

class HelloWorld < Helmet::API
  
  get '/' do |env|
    [200, {}, 'hello world']
  end

end