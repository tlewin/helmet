require 'goliath/api'

require 'helmet/templates'

module Helmet
  class API < Goliath::API
    @@routes = {}

    class << self
      include Templates

      def public_folder=(folder)
        @@public_folder = folder
      end

      def public_folder
        @@public_folder
      end

      def views_folder=(folder)
        @@views_folder = folder
      end

      def views_folder
        @@views_folder
      end

      def get(route, &block) 
        register_route('GET', route, &block);
        register_route('HEAD', route, &block);
      end
      def post(route, &block) register_route('POST', route, &block); end
      def put(route, &block) register_route('PUT', route, &block); end
      def delete(route, &block) register_route('DELETE', route, &block); end
      def head(route, &block) register_route('HEAD', route, &block); end

      def register_route(method, route, &block)
        sig = API.signature(method, route)
        @@routes[sig] = block
      end

      def signature(method, route)
        "#{method}#{route}"
      end

      def inherited(klass)
        # setup basic middlewares
        setup_middlewares klass

        # compute public/ views folder
        base = File.dirname(caller.first[/^[^:]*/])
        self.public_folder = File.join(base, 'public')
        self.views_folder = File.join(base, 'views')

        super # update Goliath::Application.app_class
      end

      private

      def setup_middlewares(klass)
        # support for session
        klass.use Rack::Session::Cookie
        # support for forms
        klass.use Goliath::Rack::Params 
      end
    end

    def response(env)
      sig = API.signature(env['REQUEST_METHOD'], env['REQUEST_PATH'])
      block = @@routes[sig]
      if block
        block.call env
      else
        [404, {}, 'not found!']
      end
    end
  end
end
  