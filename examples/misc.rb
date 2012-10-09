$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'helmet'

class Misc < Helmet::API
  
  use Rack::Static,
    :root => config(:public_folder),
    :urls => ['/css']

  get '/' do
    erb(:index, 
      {:layout => :layout}, 
      {:data => session[:data]})
  end
  
  post '/session' do
    session[:data] = env['params']['session']
    erb(:index, 
      {:layout => :layout}, 
      {:data => session[:data]})
  end
  
end