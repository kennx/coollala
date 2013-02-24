module Sinatra
  module RenderHelpers
    def render_to(template, layout=nil)
      layout ||= "layout"
      layout = "/layout/#{layout}"
      erb template.to_sym, :layout => layout.to_sym
    end

    def form_for
      buf = ''
      @_out_buf = buf
      @_out_buf.concat(yield)
    end

    def render_partial(template, *args)
      template_array = template.to_s.split('/')
      template = template_array[0..-2].join('/') + "/_#{template_array[-1]}"
      options = args.last.is_a?(Hash) ? args.pop : {}
      options.merge!(:layout => false)
      locals = options[:locals] || {}
      if collection = options.delete(:collection) then
        collection.inject([]) do |buffer, member|
          buffer << erb(:"#{template}", options.merge(:layout =>
          false, :locals => {template_array[-1].to_sym => member}.merge(locals)))
        end.join("\n")
      else
        erb(:"#{template}", options)
      end
    end
  end
  helpers RenderHelpers
end