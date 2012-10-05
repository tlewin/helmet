require 'tilt'

module Helmet
  module Templates
    
    @@template_cache = Tilt::Cache.new
        
    def erb(template, options = {}, locals = {})
     render :erb, template, options, locals
    end

    def render(engine, data, options = {}, locals = {}, &block)
      layout = options.delete(:layout)
      # force template update
      @@template_cache.clear unless Goliath.env == :production
      compiled_template = @@template_cache.fetch(data, options) do
        template = Tilt.new(find_template(engine, data), nil, options)
      end      
      output = compiled_template.render nil, locals, &block
      if layout
        return render(engine, layout, options, locals) {output}
      end
      output
    end
    
    private 
    
    def find_template(engine, template)
      filename = "#{template.to_s}.#{engine.to_s}"
      File.join(API.config(:views_folder), filename)
    end
  end
end