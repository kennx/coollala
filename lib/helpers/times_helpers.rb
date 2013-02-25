# encoding: utf-8
module Sinatra
  module Coollala
    module TimesHelpers
      def chn_time_format(time)
        return unless time.is_a? Time
        time.strftime('%Y年%m月%d日')
      end
    end
  end
  helpers Coollala::TimesHelpers
end