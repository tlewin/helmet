# TODO create test unit files
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'helmet'

class Test < Helmet::API
  
  before /\/x\S*/ do
    throw :halt, [200, {}, 'filtered!']
  end  
  
  get '/' do
    [200, {}, 'ok']
  end
end