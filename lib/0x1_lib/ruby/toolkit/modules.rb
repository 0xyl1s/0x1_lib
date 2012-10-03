# encoding: utf-8
# tested with ruby 1.9.3

module X module Lib module Toolkit module ModulesClassesMethods

  def x__lib_load_modules(a_x_lib_modules2load, s_xlib_path_base=File.join(Dir.home, '.0x1/00mu/00sourcing/0x1_lib'))
    x__abort_unless_is_a_dir(s_xlib_path_base)
    x_lib_path_base = s_xlib_path_base
    x__abort_unless_is_an_array(a_x_lib_modules2load)
    x_lib_modules2load = a_x_lib_modules2load
    x_lib_modules2load.each do |module2load|
      case module2load
      when :standard
        require "#{x_lib_path_base}/lib/0x1_lib/ruby/toolkit/standard.rb"
        extend X::Lib::Toolkit::Standard
      when :online
        require "#{x_lib_path_base}/lib/0x1_lib/ruby/toolkit/online.rb"
        extend X::Lib::Toolkit::Online
      else
        abort "E: module2load: no such module as #{module2load}"
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
