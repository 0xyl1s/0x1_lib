# encoding: utf-8
# tested with ruby 1.9.3
=begin
enabling this lib with:
require '0x1/lib/toolkit/standard.rb'
include X::Lib::Toolkit::Standard
=end

# TODO: compartimentilize themes (file_operations, network_tools, ...)
module X module Lib module Toolkit module Standard

  ################## strings
  require_relative './strings.rb'
  include X::Lib::Toolkit::Strings

  ################## numbers
  require_relative './numbers.rb'
  include X::Lib::Toolkit::Numbers

  ################## collections
  require_relative './collections.rb'
  include X::Lib::Toolkit::Collections

  ################## Files/Dirs
  require_relative './filesdirs.rb'
  include X::Lib::Toolkit::Filesdirs

  ################## IO
  require_relative './io.rb'
  include X::Lib::Toolkit::Io

  ################## datetime
  require_relative './datetime.rb'
  include X::Lib::Toolkit::Datetime

  ################## processes
  require_relative './processes.rb'
  include X::Lib::Toolkit::Processes

  ################## xutils
  require_relative './xutils.rb'
  include X::Lib::Toolkit::Xutils

  ################## deprecated
  require_relative './deprecated.rb'
  include X::Lib::Toolkit::Deprecated

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
