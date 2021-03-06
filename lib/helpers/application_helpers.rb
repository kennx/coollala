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



      def increment_floor(total_number)
        @floor_number += 1 if floor_number < total_number
      end

      def floor_name(number)
        case number
          when 1
            "<em class='num-1'>沙发</em>"
          when 2
            "<em class='num-2'>板凳</em>"
          when 3
            "<em class='num-3'>地板</em>"
          else
            "<em class='num'>#{number}楼</em>"
        end
      end

      URL_REGEX = /\b((?:https?:\/\/|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/?)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s\`!()\[\]{};:\'\".,<>?«»“”‘’]))/i
      IMAGE_REGEX = /((^http:\/\/)?(ww[0-9])\.(sinaimg)\.cn\/(bmiddle)\/(\w+)\.(jpg|bmp|png|gif)$)/i
      def auto_format(string)
        string = '' if string.nil?
        string = string.to_str
        string = string.dup
        string = CGI::escape_html(string)
        string = auto_link(string) if string.scan(URL_REGEX).any?
        string.gsub!(/\r\n?/, "\n")
        string.gsub!(/\n\n+/, "</p>\n\n<p>")
        string.gsub!(/([^\n]\n)(?=[^\n])/, '<br />')
        string.insert(0, "<p>")
        string.insert(-1, "</p>")
      end

      def auto_link(string)
        string = string.dup
        string = string.gsub(URL_REGEX) do |match|
          url_type(match)
        end
        string
      end

      def url_type(url)
        if url.scan(IMAGE_REGEX).any?
          string = CGI::unescape_html("\s <a href='#{url}' target='_blank'><img class='image' src='#{url}' /></a> \s")
        elsif url.scan(URL_REGEX)
          string = CGI::unescape_html("\s <a href='#{url}' target='_blank'>#{url}</a> \s")
        else
          string = url
        end
        string
      end


      def replies_counter(topic)
        if topic.replies_count == 0
          "<div class='gray-counter'>#{topic.replies_count}</div>"
        elsif topic.replies_count > 99
          "<div class='red-counter'>99</div>"
        else
          "<div class='blue-counter'>#{topic.replies_count}</div>"
        end
      end

      private

      def floor_number
        @floor_number ||= 0
      end




    end
  end
  helpers Coollala::ApplicationHelpers
end