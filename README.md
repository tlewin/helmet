# Helmet
 
Helmet is a non-blocking (asynchronous) web framework built on top of [Goliath Web Server](https://github.com/postrank-labs/goliath/).

The Helmet semantics is inspired on [Sinatra framework](http://www.sinatrarb.com/) and brings to Goliath some nice features:

- HTTP Route processing, using the kick-ass [http_router gem](https://github.com/joshbuddy/http_router).
- Simplified template support, using the [tilt gem](https://github.com/rtomayko/tilt).
- Helpers support.

## Example

Create hello.rb:

```ruby
require 'helmet'

class Hello < Helmet::API
  
  helpers do

    def say_hello name
      "Hello #{name}!!!"
    end

  end

  get '/:name' do
    say_hello params[:name]
  end

end
```

Run it from command line:
    
    ruby hello.rb

For more information, see `/examples` directory.

## Instalation

Install from rubygem repository:

    gem install helmet

Install from source:

    rake gem 

## License

Helmet is released under MIT license. Please, take a look at LICENSE file.