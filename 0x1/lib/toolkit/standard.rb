# encoding: utf-8
# tested with ruby 1.9.3
=begin
enabling this lib with:
require '0x1/lib/toolkit/standard.rb'
include X::Lib::Toolkit::Standard
=end

# TODO: compartimentilize themes (file_operations, network_tools, ...)
module X module Lib module Toolkit module Standard
  require 'fileutils'

  ################## strings
  require_relative './strings.rb'

  ################## numbers
  require_relative './numbers.rb'

  ################## collections
  require_relative './collection.rb'

  ################## IO
  require_relative './io.rb'

  ################## datetime
  require_relative './datetime.rb'

  ################## processes
  require_relative './processes.rb'

  ################## 0x1utils
  require_relative './processes.rb'

  ################## 0deprecated
  require_relative './0deprecated.rb'

end end end end


# ____________________________________________________________________
# >>>>>  projet epiculture/ec1   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{{{
# Sources, Infos & Contact : http://www.epiculture.org
# Author: Pierre-Maël Crétinon
# License: GNU GPLv3 ( www.epiculture.org/ec1/LICENSE )
# Copyright: 2010-2012 Pierre-Maël Crétinon
# Sponsor: studio Helianova - http://studio.helianova.com
# ――――――――――――――――――――――――――――――――――――――#}}}
# vim: 
