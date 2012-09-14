$LOAD_PATH.unshift File.join('..', 'lib')
require 'helmet'

class Misc < Helmet::API
  
  use Rack::Static,
    :root => public_folder,
    :urls => ['/css']

  get '/' do |env|
    session = env['rack.session']
    [200, {}, erb(:index, {:layout => :layout}, {:data => session[:data]})]
  end
  
  post '/session' do |env|
    session = env['rack.session']
    session[:data] = env['params']['session']
    [200, {}, erb(:index, {:layout => :layout}, {:data => session[:data]})]
  end
  
end