module Sinatra
  module Coollala
    module ApplicationHelpers
      def current_page?(url)
        current_page == url
      end

      def current_page
        request.path_info
      end

      def meta_title(title=nil)
        if title.nil?
          settings.app_cn_name
        else
          "#{title} - #{settings.app_cn_name}"
        end
      end

      def automatic_each(object)
        arr = []
        if object.is_a?(Hash)
          object.each_value do |value|
            arr << value
          end
        else
          arr << object
        end
        arr.flatten
      end

    end
  end
  helpers Coollala::ApplicationHelpers
end