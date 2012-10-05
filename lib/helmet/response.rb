module Helmet
  
  class Response
    # Request environment
    attr_reader :env
    
    # HTTP response status
    attr_accessor :status
    
    # HTTP response header
    attr_accessor :header
    
    # HTTP response body
    attr_accessor :body
    
    def initialize(env)
      @env      = env
      @status   = 200 # Default OK!
      @header   = {}
      @body     = ''
    end
    
    # @return (Array) HTTP response tuple [status, header, body]
    def format_response
      [@status, @header, @body]
    end
  end
end