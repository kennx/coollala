# encoding: utf-8
require 'cgi/util'
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

      URI_REGEX = /\b((?:https?:\/\/|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/?)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s\`!()\[\]{};:\'\".,<>?«»“”‘’]))/i
      def auto_format(string)
        string = '' if string.nil?
        string = string.dup
        string = CGI::escape_html(string)
        string = string.to_str
        string = auto_link(string) if string.scan(URI_REGEX).any?
        string.gsub!(/\r\n?/, "\n")
        string.gsub!(/\n\n+/, "</p>\n\n<p>")
        string.gsub!(/([^\n]\n)(?=[^\n])/, '<br />')
        string.insert(0, "<p>")
        string.insert(-1, "</p>")
      end

      def auto_link(string)
        string = string.dup
        string = string.gsub(URI_REGEX) do |match|
          CGI::unescape_html("<a href='#{match}' target='_blank'>#{match}</a>")
        end
        string
      end


    end
  end
  helpers Coollala::ApplicationHelpers
end