require 'goliath/api'
require 'goliath/constants'
require 'http_router'

require 'helmet/handler'

require 'pry'

module Helmet
  class API < Goliath::API
    
    class << self
      
      def set(key, value)
        @config[key.to_sym] = value
      end

      def config(key)
        @config[key.to_sym]
      end
      
      def before(route, opts = {}, &block)
        @before_filters.add(route, opts, &block)
      end
      
      def routes
        @routes
      end
      
      def before_filters
        @before_filters
      end
      
      # include methods to the helper
      def helpers(&block)
        @helpers.module_exec(&block)
      end
      
      def get_helpers
        @helpers
      end
      
      def get(route, opts = {}, &block) 
        register_route(:GET, route, opts, &block);
        # HttpRouter already include head
        # register_route('HEAD', route, opts, &block);
      end
      
      def connect(route, opts = {}, &block) register_route(:CONNECT, route, opts, &block); end
      def delete(route, opts = {}, &block) register_route(:DELETE, route, opts, &block); end
      # def head(route, opts = {}, &block) register_route(:HEAD, route, opts, &block); end
      # def options(route, opts = {}, &block) register_route(:OPTIONS, route, opts, &block); end
      def post(route, opts = {}, &block) register_route(:POST, route, opts, &block); end
      def put(route, opts = {}, &block) register_route(:PUT, route, opts, &block); end

      def register_route(method, route, opts = {}, &block)       
        case method
        when :GET
          @routes.get(route, opts, &block)
        when :CONNECT
          @routes.connect(route, opts, &block)
        when :DELETE
          @routes.delete(route, opts, &block)
        when :OPTIONS
          @routes.options(route, opts, &block)
        when :POST
          @routes.post(route, opts, &block)
        when :PUT
          @routes.put(route, opts, &block)
        end
      end
    
      def inherited(klass)
        klass.init
        
        # setup basic middlewares
        setup_middlewares klass

        # compute public/ views folder
        base = File.expand_path(File.dirname(caller.first[/^[^:]*/]))
        klass.set :public_folder, File.join(base, 'public')
        klass.set :views_folder, File.join(base, 'views')

        super # update Goliath::Application.app_class
      end

      def init
        # Handle application routes
        @routes          = HttpRouter.new

        # Handle before filters
        @before_filters  = HttpRouter.new

        @config          = {}
        
        @helpers         = Module.new
      end

      private
            
      def setup_middlewares(klass)
        # support for forms
        klass.use Goliath::Rack::Params 
      end
    end

    def response(env)
      # request handler
      handler = Handler.new(env, self.class)
      
      # include Helpers
      handler.extend(self.class.get_helpers)

      catch(:halt) do
        # evaluate any route match
        filters = self.class.before_filters.recognize(env).first 

        filters.each do |f|
          # include route params into env
          route_params = f.params
          env.params.merge! route_params
          
          handler.handle! &f.route.dest
          
          # remove after usage
          env.params.delete_if {|k,v| route_params[k] == v}
        end if filters

        routes_recognized = self.class.routes.recognize(env).first 
        if routes_recognized
          # Use the first matched route
          http_router_response = routes_recognized.first
          # Bind params to the env
          env.params.merge! http_router_response.params
          handler.handle! &http_router_response.route.dest
        else
          handler.handle! do
            status 404
            'not found!'
          end
        end
      end
      
      handler.response.format_response
    end
  end
end
  