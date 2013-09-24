require 'tilt'

module Helmet
  module Templates
    
    @@template_cache = Tilt::Cache.new
        
    def erb(template, options = {}, locals = {})
      render(:erb, template, options, locals) 
    end

    def render(engine, data, options = {}, locals = {}, &block)
      layout = options[:layout]
      layout = :layout if layout.nil?
      # force template update
      @@template_cache.clear unless Goliath.env == :production
      compiled_template = @@template_cache.fetch(data, options) do
        template = Tilt.new(find_template(engine, data), nil, options)
      end
      output = compiled_template.render(self, locals, &block)
      if layout
        begin
          options.merge!(layout: false)
          return render(engine, layout, options, locals) {output}
        rescue 
          # Do nothing
        end
      end
      output
    end
    
    private 
    
    def find_template(engine, template)
      filename = "#{template.to_s}.#{engine.to_s}"
      File.join(@klass.settings[:views_folder], filename)
    end
  end

end