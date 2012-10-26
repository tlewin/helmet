$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'helmet'

class Helper < Helmet::API
  
  helpers do
    def xs(num)
      'x' * num
    end
  end
  
  get '/' do
    num = (params['x'] || 0).to_i
    xs(num)
  end
  
end