$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'helmet'

class HelloWorld < Helmet::API
  
  get '/' do 
    'hello world'
  end

end