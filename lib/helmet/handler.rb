require 'helmet/templates'
require 'helmet/response'

require 'rack/mime'

module Helmet

  # Handle each request and provide usefull methods for request handling
  class Handler
    include Templates
    
    # Request environment
    attr_reader :env
    
    attr_reader :response
    
    def initialize(env, klass)
      @env      = env
      @klass    = klass
      @response = Response.new(env)
    end
    
    # @return (Response) request response
    def handle!(&block)
      @response.body = instance_exec(&block)
      @response.format_response
    end
    
    # @return (Rack::Session) the current session data
    def session
      @env['rack.session']
    end
    
    # Creates a redirect HTTP response
    def redirect(uri)
      @response.status = 302
      @response.header['Location'] = uri
      @response.body = ''
      halt
    end
    
    # halt the execution
    def halt(body=nil)
      @response.body = body if body
      throw :halt
    end
    
    # @return (Integer) response status code
    def status
      @response.status
    end

    # set response status code
    def status(code)
      @response.status = code
    end
    
    # @return (Hash) response header
    def header
      @response.header
    end
    
    # @return (String) response body
    def body
      @response.body
    end
    
    # @return (Hash) request params
    def params
      env.params || {}
    end

    # @return [Hash] config object
    def config
      env.config
    end
    
    # Set content-type header based on extension
    #
    # @param [String, Symbol] ext mime extension
    # @return [String] mime type (@see mime_type)
    def content_type ext
      header['Content-Type'] = mime_type(ext)
    end

    # Return mime type based on extension
    # Uses Rack::Mime library.
    #
    # @param [String, Symbol] ext mime type extension
    # @return [String] mime type
    def mime_type ext
      Rack::Mime.mime_type ".#{ext}"
    end
  end
end