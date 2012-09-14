Helmet
======

Simple web framework for Goliath web server.

Helmet is inspired on Sinatra framework  (https://github.com/bmizerany/sinatra) without losing the Goliath API design.
The framework tries some functionalities that Goliath doesn't provide out of the box, like:

  - Session management
  - Simplified template support
  - Simple notation for HTTP verbs and filters

This is the very first version, all the APIand code will be reviewed.

Example
=======

```ruby
require 'helmet'

class Misc < Helmet::API
  
  use Rack::Static,
    :root => public_folder, # Default: ./public
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
```
See examples directory

License
=======
Goliath License, (https://github.com/postrank-labs/goliath/blob/master/LICENSE)
 
Credits
=======

Helmet is copyright Thiago Lewin <thiago_lewin@yahoo.com.br>