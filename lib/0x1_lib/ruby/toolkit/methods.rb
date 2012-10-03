# encoding: utf-8
# tested with ruby 1.9.3

module X module Lib module Toolkit module ModulesClassesMethods

  def x__grandparent_method_name()
    x__callee_method_name(caller[1])
  end

  def x__callee_method_name(s_caller_rawinfo)
    s_caller_rawinfo[/`([^']*)'/, 1]
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
