module Sinatra
  module Coollala
    module TagsHelpers
      def hidden_field_tag(options)
        method = options.delete(:methods)
        csrf   = options[:csrf] || false
        if csrf
          field_tags = csrf_tag
          field_tags << methods_tag(method)
        else
          field_tags = methods_tag(method)
        end
        field_tags
      end

      def methods_tag(method)
        %Q(<input type="hidden" name="_method" value="#{method}" />)
      end

      def csrf_tag
        Rack::Csrf.csrf_tag(env)
      end

      def csrf_token
        Rack::Csrf.csrf_token(env)
      end

      def csrf_field
        Rack::Csrf.csrf_field
      end
    end
  end
  helpers Coollala::TagsHelpers
end