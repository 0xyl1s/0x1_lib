# encoding: utf-8
# tested with ruby 1.9.3

module X module Lib module Toolkit module Modules

  def x__lib_load_modules(x__lib_modules2load)
    unless x__lib_modules2load.is_a?(Array)
      abort "X: x__lib_modules2load must be an array (#{x__lib_modules2load.class})"
    end
    x__lib_modules2load.each do |module2load|
      case module2load
      when :standard
        require "#{@x_lib_path_base}/lib/0x1_lib/toolkit/standard.rb"
        extend X::Lib::Toolkit::Standard
      when :online
        require "#{@x_lib_path_base}/lib/0x1_lib/toolkit/online.rb"
        extend X::Lib::Toolkit::Online
      else
        abort "X: module2load: no such module as #{module2load}"
      end
    end
  end

end end end end

# ____________________________________________________________________
# >>>>>  projet epiculture/ec1   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{{{
# Sources, Infos & Contact : http://www.epiculture.org
# Author: Pierre-Maël Crétinon
# License: GNU GPLv3 ( www.epiculture.org/ec1/LICENSE )
# Copyright: 2010-2012 Pierre-Maël Crétinon
# Sponsor: studio Helianova - http://studio.helianova.com
# ――――――――――――――――――――――――――――――――――――――#}}}
# vim: ft=ruby
