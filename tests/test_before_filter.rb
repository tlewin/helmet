# TODO create test unit files
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'helmet'

class Test < Helmet::API
  
  before /\/x\S*/ do
    halt 'filtered!'
  end  
  
  get '/' do
    'ok'
  end
  
  get '/redirect' do
    redirect 'http://www.google.com'
  end
end